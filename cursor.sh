#!/usr/bin/env bash
CURSOR_THEME="Bibata-Modern-Ice"
CURSOR_SIZE=24
CURSOR_DIR="$HOME/.local/share/icons"

mkdir -p "$CURSOR_DIR"

CURSOR_URL=$(curl -s https://api.github.com/repos/ful1e5/Bibata_Cursor/releases/latest \
    | grep "browser_download_url" \
    | grep "${CURSOR_THEME}.tar.xz" \
    | cut -d '"' -f4)

curl -L "$CURSOR_URL" -o /tmp/bibata.tar.xz
tar -xf /tmp/bibata.tar.xz -C "$CURSOR_DIR"
rm -f /tmp/bibata.tar.xz

mkdir -p "$HOME/.icons/default"
cat > "$HOME/.icons/default/index.theme" <<EOF
[Icon Theme]
Inherits=${CURSOR_THEME}
EOF

gsettings set org.gnome.desktop.interface cursor-theme "${CURSOR_THEME}"
gsettings set org.gnome.desktop.interface cursor-size ${CURSOR_SIZE}
