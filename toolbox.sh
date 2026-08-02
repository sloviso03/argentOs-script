#!/usr/bin/env bash

set -e

sudo apt update
sudo apt install -y wget curl libfuse2t64 libgl1 libxcb-cursor0 jq

TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

DOWNLOAD_URL=$(curl -s 'https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release' | jq -r '.TBA[0].downloads.linux.link')

wget -q --show-progress -O toolbox.tar.gz "$DOWNLOAD_URL"

tar -xzf toolbox.tar.gz

TOOLBOX_BIN=$(find . -maxdepth 3 -type f -name "jetbrains-toolbox" | head -n 1)

if [ -z "$TOOLBOX_BIN" ]; then
    rm -rf "$TMP_DIR"
    exit 1
fi

INSTALL_DIR="$HOME/.local/share/JetBrains/Toolbox/bin"
mkdir -p "$INSTALL_DIR"
cp "$TOOLBOX_BIN" "$INSTALL_DIR/jetbrains-toolbox"
chmod +x "$INSTALL_DIR/jetbrains-toolbox"

mkdir -p "$HOME/.local/bin"
ln -sf "$INSTALL_DIR/jetbrains-toolbox" "$HOME/.local/bin/jetbrains-toolbox"

mkdir -p "$HOME/.local/share/applications"
cat <<EOF > "$HOME/.local/share/applications/jetbrains-toolbox.desktop"
[Desktop Entry]
Type=Application
Name=JetBrains Toolbox
Exec=$INSTALL_DIR/jetbrains-toolbox
Icon=jetbrains-toolbox
Comment=JetBrains Toolbox App
Terminal=false
Categories=Development;
EOF

cd ~
rm -rf "$TMP_DIR"
