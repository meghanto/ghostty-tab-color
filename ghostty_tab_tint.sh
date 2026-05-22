#!/usr/bin/env bash
# Hue-rotate the Ghostty background in OKLCH, then rescale to match original luminance
slot=${1:-1}

config="$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
bg_hex=$(grep -m1 '^background' "$config" 2>/dev/null | grep -oE '[0-9a-fA-F]{6}')
bg_hex=${bg_hex:-14171d}

r=$((16#${bg_hex:0:2}))
g=$((16#${bg_hex:2:2}))
b=$((16#${bg_hex:4:2}))

awk -v r="$r" -v g="$g" -v b="$b" -v slot="$slot" '
function lin(c) {
    return c <= 0.04045 ? c / 12.92 : exp(2.4 * log((c + 0.055) / 1.055))
}
function srgb(c) {
    c = c < 0 ? 0 : (c > 1 ? 1 : c)
    return c <= 0.0031308 ? 12.92 * c : 1.055 * exp(log(c) / 2.4) - 0.055
}
function cbrt(x) {
    return x >= 0 ? exp(log(x) / 3) : -exp(log(-x) / 3)
}
BEGIN {
    pi = 3.14159265358979

    r /= 255; g /= 255; b /= 255

    # sRGB -> linear
    rl = lin(r); gl = lin(g); bl = lin(b)

    # Save original luminance
    Y_orig = 0.2126*rl + 0.7152*gl + 0.0722*bl

    # Linear RGB -> XYZ D65
    X = 0.4124564*rl + 0.3575761*gl + 0.1804375*bl
    Y = 0.2126729*rl + 0.7151522*gl + 0.0721750*bl
    Z = 0.0193339*rl + 0.1191920*gl + 0.9503041*bl

    # XYZ -> Oklab
    lms_l = cbrt(0.8189330101*X + 0.3618667424*Y - 0.1288597137*Z)
    lms_m = cbrt(0.0329845436*X + 0.9293118715*Y + 0.0361456387*Z)
    lms_s = cbrt(0.0482003018*X + 0.2643662691*Y + 0.6338517070*Z)

    L    =  0.2104542553*lms_l + 0.7936177850*lms_m - 0.0040720468*lms_s
    a    =  1.9779984951*lms_l - 2.4285922050*lms_m + 0.4505937099*lms_s
    b_ok =  0.0259040371*lms_l + 0.7827717662*lms_m - 0.8086757660*lms_s

    # Oklab -> OKLCH, rotate hue, back to Oklab
    C = sqrt(a*a + b_ok*b_ok)
    if (C < 0.01) C = 0.01
    H = atan2(b_ok, a) + ((slot - 1) / 14.0 * 180 - 90) * pi / 180
    C = C * (1 - (slot - 8 < 0 ? 8 - slot : slot - 8) * 0.01)
    a    = C * cos(H)
    b_ok = C * sin(H)

    # Oklab -> XYZ
    lms_l = L + 0.3963377774*a + 0.2158037573*b_ok
    lms_m = L - 0.1055613458*a - 0.0638541728*b_ok
    lms_s = L - 0.0894841775*a - 1.2914855480*b_ok

    lms_l = lms_l*lms_l*lms_l
    lms_m = lms_m*lms_m*lms_m
    lms_s = lms_s*lms_s*lms_s

    X =  4.0767416621*lms_l - 3.3077115913*lms_m + 0.2309699292*lms_s
    Y = -1.2684380046*lms_l + 2.6097574011*lms_m - 0.3413193965*lms_s
    Z = -0.0041960863*lms_l - 0.7034186147*lms_m + 1.7076147010*lms_s

    # XYZ -> linear RGB
    rl =  3.2404542*X - 1.5371385*Y - 0.4985314*Z
    gl = -0.9692660*X + 1.8760108*Y + 0.0415560*Z
    bl =  0.0556434*X - 0.2040259*Y + 1.0572252*Z

    # Clamp to [0,1] before rescaling so scale factor never exceeds 1
    rl = rl < 0 ? 0 : (rl > 1 ? 1 : rl)
    gl = gl < 0 ? 0 : (gl > 1 ? 1 : gl)
    bl = bl < 0 ? 0 : (bl > 1 ? 1 : bl)

    # Rescale to restore original luminance
    Y_new = 0.2126*rl + 0.7152*gl + 0.0722*bl
    if (Y_new > 0) {
        s = Y_orig / Y_new
        rl *= s; gl *= s; bl *= s
    }

    printf "%02x/%02x/%02x\n", int(srgb(rl)*255+0.5), int(srgb(gl)*255+0.5), int(srgb(bl)*255+0.5)
}
'
