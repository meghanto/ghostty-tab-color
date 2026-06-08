#!/usr/bin/env bash
# Curated palettes for 20 premium dark terminal themes
# Returns space-separated list: bg fg cursor ansi0 ansi1 ... ansi15

input=${1:-1}

# If slot index number, resolve modulo 9 (visually distinct rotation)
if [[ "$input" =~ ^[0-9]+$ ]]; then
    slot=$(( (input - 1) % 9 + 1 ))
    case "$slot" in
        1) theme="london_soho_night" ;;
        2) theme="solarized" ;;
        3) theme="synthwave_everything" ;;
        4) theme="zenbones_dark" ;;
        5) theme="nightfox" ;;
        6) theme="nord" ;;
        7) theme="catppuccin" ;;
        8) theme="gruvbox" ;;
        9) theme="everforest" ;;
    esac
else
    # Normalize string to lowercase and replace dashes with underscores for consistency
    theme=$(echo "$input" | tr '[:upper:]' '[:lower:]' | tr '-' '_')
fi

case "$theme" in
    catppuccin)
        bg="#1e1e2e"; fg="#cdd6f4"; cursor="#f5e0dc"
        ansi0="#45475a"; ansi1="#f38ba8"; ansi2="#a6e3a1"; ansi3="#f9e2af"; ansi4="#89b4fa"; ansi5="#f5c2e7"; ansi6="#94e2d5"; ansi7="#a6adc8"
        ansi8="#585b70"; ansi9="#f37799"; ansi10="#89d88b"; ansi11="#ebd391"; ansi12="#74a8fc"; ansi13="#f2aede"; ansi14="#6bd7ca"; ansi15="#bac2de"
        ;;
    tokyonight)
        bg="#1a1b26"; fg="#c0caf5"; cursor="#c0caf5"
        ansi0="#15161e"; ansi1="#f7768e"; ansi2="#9ece6a"; ansi3="#e0af68"; ansi4="#7aa2f7"; ansi5="#bb9af7"; ansi6="#7dcfff"; ansi7="#a9b1d6"
        ansi8="#414868"; ansi9="#f7768e"; ansi10="#9ece6a"; ansi11="#e0af68"; ansi12="#7aa2f7"; ansi13="#bb9af7"; ansi14="#7dcfff"; ansi15="#c0caf5"
        ;;
    nord)
        bg="#2e3440"; fg="#d8dee9"; cursor="#eceff4"
        ansi0="#3b4252"; ansi1="#bf616a"; ansi2="#a3be8c"; ansi3="#ebcb8b"; ansi4="#81a1c1"; ansi5="#b48ead"; ansi6="#88c0d0"; ansi7="#e5e9f0"
        ansi8="#596377"; ansi9="#bf616a"; ansi10="#a3be8c"; ansi11="#ebcb8b"; ansi12="#81a1c1"; ansi13="#b48ead"; ansi14="#8fbcbb"; ansi15="#eceff4"
        ;;
    gruvbox)
        bg="#282828"; fg="#ebdbb2"; cursor="#ebdbb2"
        ansi0="#282828"; ansi1="#cc241d"; ansi2="#98971a"; ansi3="#d79921"; ansi4="#458588"; ansi5="#b16286"; ansi6="#689d6a"; ansi7="#a89984"
        ansi8="#928374"; ansi9="#fb4934"; ansi10="#b8bb26"; ansi11="#fabd2f"; ansi12="#83a598"; ansi13="#d3869b"; ansi14="#8ec07c"; ansi15="#ebdbb2"
        ;;
    solarized)
        bg="#001e27"; fg="#708284"; cursor="#708284"
        ansi0="#002831"; ansi1="#d11c24"; ansi2="#738a05"; ansi3="#a57706"; ansi4="#2176c7"; ansi5="#c61c6f"; ansi6="#259286"; ansi7="#eae3cb"
        ansi8="#475b62"; ansi9="#bd3613"; ansi10="#475b62"; ansi11="#536870"; ansi12="#708284"; ansi13="#5956ba"; ansi14="#819090"; ansi15="#fcf4dc"
        ;;
    rosepine)
        bg="#191724"; fg="#e0def4"; cursor="#e0def4"
        ansi0="#26233a"; ansi1="#eb6f92"; ansi2="#31748f"; ansi3="#f6c177"; ansi4="#9ccfd8"; ansi5="#c4a7e7"; ansi6="#ebbcba"; ansi7="#e0def4"
        ansi8="#6e6a86"; ansi9="#eb6f92"; ansi10="#31748f"; ansi11="#f6c177"; ansi12="#9ccfd8"; ansi13="#c4a7e7"; ansi14="#ebbcba"; ansi15="#e0def4"
        ;;
    dracula)
        bg="#282a36"; fg="#f8f8f2"; cursor="#f8f8f2"
        ansi0="#21222c"; ansi1="#ff5555"; ansi2="#50fa7b"; ansi3="#f1fa8c"; ansi4="#bd93f9"; ansi5="#ff79c6"; ansi6="#8be9fd"; ansi7="#f8f8f2"
        ansi8="#6272a4"; ansi9="#ff6e6e"; ansi10="#69ff94"; ansi11="#ffffa5"; ansi12="#d6acff"; ansi13="#ff92df"; ansi14="#a4ffff"; ansi15="#ffffff"
        ;;
    everforest)
        bg="#1e2326"; fg="#d3c6aa"; cursor="#e69875"
        ansi0="#7a8478"; ansi1="#e67e80"; ansi2="#a7c080"; ansi3="#dbbc7f"; ansi4="#7fbbb3"; ansi5="#d699b6"; ansi6="#83c092"; ansi7="#f2efdf"
        ansi8="#a6b0a0"; ansi9="#f85552"; ansi10="#8da101"; ansi11="#dfa000"; ansi12="#3a94c5"; ansi13="#df69ba"; ansi14="#35a77c"; ansi15="#fffbef"
        ;;
    pnevma)
        bg="#1c1c1c"; fg="#d0d0d0"; cursor="#e4c9af"
        ansi0="#2f2e2d"; ansi1="#a36666"; ansi2="#90a57d"; ansi3="#d7af87"; ansi4="#7fa5bd"; ansi5="#c79ec4"; ansi6="#8adbb4"; ansi7="#d0d0d0"
        ansi8="#4a4845"; ansi9="#d78787"; ansi10="#afbea2"; ansi11="#e4c9af"; ansi12="#a1bdce"; ansi13="#d7beda"; ansi14="#b1e7dd"; ansi15="#efefef"
        ;;
    rippedcasts)
        bg="#2b2b2b"; fg="#ffffff"; cursor="#7f7f7f"
        ansi0="#000000"; ansi1="#cdaf95"; ansi2="#a8ff60"; ansi3="#bfbb1f"; ansi4="#75a5b0"; ansi5="#ff73fd"; ansi6="#5a647e"; ansi7="#bfbfbf"
        ansi8="#666666"; ansi9="#eecbad"; ansi10="#bcee68"; ansi11="#e5e500"; ansi12="#86bdc9"; ansi13="#e500e5"; ansi14="#8c9bc4"; ansi15="#e5e5e5"
        ;;
    zenbones_dark)
        bg="#1c1917"; fg="#b4bdc3"; cursor="#c4cacf"
        ansi0="#1c1917"; ansi1="#de6e7c"; ansi2="#819b69"; ansi3="#b77e64"; ansi4="#6099c0"; ansi5="#b279a7"; ansi6="#66a5ad"; ansi7="#b4bdc3"
        ansi8="#4d4540"; ansi9="#e8838f"; ansi10="#8bae68"; ansi11="#d68c67"; ansi12="#61abda"; ansi13="#cf86c1"; ansi14="#65b8c1"; ansi15="#888f94"
        ;;
    synthwave_everything)
        bg="#2a2139"; fg="#f0eff1"; cursor="#72f1b8"
        ansi0="#fefefe"; ansi1="#f97e72"; ansi2="#72f1b8"; ansi3="#fede5d"; ansi4="#6d77b3"; ansi5="#c792ea"; ansi6="#f772e0"; ansi7="#fefefe"
        ansi8="#fefefe"; ansi9="#f88414"; ansi10="#72f1b8"; ansi11="#fff951"; ansi12="#36f9f6"; ansi13="#e1acff"; ansi14="#f92aad"; ansi15="#fefefe"
        ;;
    kanso_ink)
        bg="#14171d"; fg="#c5c9c7"; cursor="#c5c9c7"
        ansi0="#14171d"; ansi1="#c4746e"; ansi2="#8a9a7b"; ansi3="#c4b28a"; ansi4="#8ba4b0"; ansi5="#a292a3"; ansi6="#8ea4a2"; ansi7="#c8c093"
        ansi8="#a4a7a4"; ansi9="#e46876"; ansi10="#87a987"; ansi11="#e6c384"; ansi12="#7fb4ca"; ansi13="#938aa9"; ansi14="#7aa89f"; ansi15="#c5c9c7"
        ;;
    kanso_mist)
        bg="#22262d"; fg="#c5c9c7"; cursor="#c5c9c7"
        ansi0="#22262d"; ansi1="#c4746e"; ansi2="#8a9a7b"; ansi3="#c4b28a"; ansi4="#8ba4b0"; ansi5="#a292a3"; ansi6="#8ea4a2"; ansi7="#a4a7a4"
        ansi8="#5c6066"; ansi9="#e46876"; ansi10="#87a987"; ansi11="#e6c384"; ansi12="#7fb4ca"; ansi13="#938aa9"; ansi14="#7aa89f"; ansi15="#c5c9c7"
        ;;
    guezwhoz)
        bg="#1d1d1d"; fg="#d9d9d9"; cursor="#99d4b1"
        ansi0="#333333"; ansi1="#e85181"; ansi2="#7ad694"; ansi3="#b7d074"; ansi4="#5aa0d6"; ansi5="#9a90e0"; ansi6="#58d6ce"; ansi7="#d9d9d9"
        ansi8="#808080"; ansi9="#e85181"; ansi10="#afd7af"; ansi11="#d1ed85"; ansi12="#64b2ed"; ansi13="#a398ed"; ansi14="#61ede4"; ansi15="#ededed"
        ;;
    adwaita_dark)
        bg="#1d1d20"; fg="#ffffff"; cursor="#ffffff"
        ansi0="#241f31"; ansi1="#c01c28"; ansi2="#2ec27e"; ansi3="#f5c211"; ansi4="#1e78e4"; ansi5="#9841bb"; ansi6="#0ab9dc"; ansi7="#c0bfbc"
        ansi8="#5e5c64"; ansi9="#ed333b"; ansi10="#57e389"; ansi11="#f8e45c"; ansi12="#51a1ff"; ansi13="#c061cb"; ansi14="#4fd2fd"; ansi15="#f6f5f4"
        ;;
    london_soho_night)
        bg="#001a12"; fg="#00ebc8"; cursor="#00ffb1"
        ansi0="#002a1a"; ansi1="#00d44a"; ansi2="#008f5e"; ansi3="#00e84a"; ansi4="#006ab5"; ansi5="#00d9a5"; ansi6="#009aa8"; ansi7="#00ebc8"
        ansi8="#006b48"; ansi9="#00e865"; ansi10="#00aa74"; ansi11="#00f460"; ansi12="#0088c8"; ansi13="#00edb8"; ansi14="#00b8bd"; ansi15="#00f8d2"
        ;;
    monokai_pro_octagon)
        bg="#282a3a"; fg="#eaf2f1"; cursor="#b2b9bd"
        ansi0="#282a3a"; ansi1="#ff657a"; ansi2="#bad761"; ansi3="#ffd76d"; ansi4="#ff9b5e"; ansi5="#c39ac9"; ansi6="#9cd1bb"; ansi7="#eaf2f1"
        ansi8="#696d77"; ansi9="#ff657a"; ansi10="#bad761"; ansi11="#ffd76d"; ansi12="#ff9b5e"; ansi13="#c39ac9"; ansi14="#9cd1bb"; ansi15="#eaf2f1"
        ;;
    monokai_soda)
        bg="#1a1a1a"; fg="#c4c5b5"; cursor="#f6f7ec"
        ansi0="#1a1a1a"; ansi1="#f4005f"; ansi2="#98e024"; ansi3="#fa8419"; ansi4="#9d65ff"; ansi5="#f4005f"; ansi6="#58d1eb"; ansi7="#c4c5b5"
        ansi8="#625e4c"; ansi9="#f4005f"; ansi10="#98e024"; ansi11="#e0d561"; ansi12="#9d65ff"; ansi13="#f4005f"; ansi14="#58d1eb"; ansi15="#f6f6ef"
        ;;
    nightfox)
        bg="#192330"; fg="#cdcecf"; cursor="#cdcecf"
        ansi0="#393b44"; ansi1="#c94f6d"; ansi2="#81b29a"; ansi3="#dbc074"; ansi4="#719cd6"; ansi5="#9d79d6"; ansi6="#63cdcf"; ansi7="#dfdfe0"
        ansi8="#575860"; ansi9="#d16983"; ansi10="#8ebaa4"; ansi11="#e0c989"; ansi12="#86abdc"; ansi13="#baa1e2"; ansi14="#7ad5d6"; ansi15="#e4e4e5"
        ;;
    *)
        # Exit with error if theme is invalid
        exit 1
        ;;
esac

# Echo all 19 colors separated by space
echo "$bg $fg $cursor $ansi0 $ansi1 $ansi2 $ansi3 $ansi4 $ansi5 $ansi6 $ansi7 $ansi8 $ansi9 $ansi10 $ansi11 $ansi12 $ansi13 $ansi14 $ansi15"
