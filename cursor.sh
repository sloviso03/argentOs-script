#!/usr/bin/env bash
CURSOR_THEME="Bibata-Modern-Ice"
CURSOR_SIZE=24
CURSOR_DIR="$HOME/.icons"

mkdir -p "$CURSOR_DIR"

echo "Obteniendo URL de descarga para Bibata-Modern-Ice..."
CURSOR_URL=$(curl -s https://api.github.com/repos/ful1e5/Bibata_Cursor/releases/latest \
    | grep "browser_download_url" \
    | grep -i "${CURSOR_THEME}.tar.xz" \
    | cut -d '"' -f4)

if [ -z "$CURSOR_URL" ]; then
    echo "Error: No se pudo obtener la URL de descarga del cursor."
else
    echo "Descargando cursor desde: $CURSOR_URL"
    curl -L "$CURSOR_URL" -o /tmp/bibata.tar.xz

    echo "Extrayendo cursor..."
    tar -xf /tmp/bibata.tar.xz -C "$CURSOR_DIR"
    rm -f /tmp/bibata.tar.xz
fi

mkdir -p "$HOME/.icons/default"
cat > "$HOME/.icons/default/index.theme" <<EOF
[Icon Theme]
Inherits=${CURSOR_THEME}
Name=Default
Comment=Default Cursor Theme
EOF

GTK_SETTINGS="$HOME/.config/gtk-3.0/settings.ini"
mkdir -p "$(dirname "$GTK_SETTINGS")"
if [ ! -f "$GTK_SETTINGS" ]; then
    echo "[Settings]" > "$GTK_SETTINGS"
fi

sed -i '/gtk-cursor-theme-name/d' "$GTK_SETTINGS"
sed -i '/gtk-cursor-theme-size/d' "$GTK_SETTINGS"
echo "gtk-cursor-theme-name=${CURSOR_THEME}" >> "$GTK_SETTINGS"
echo "gtk-cursor-theme-size=${CURSOR_SIZE}" >> "$GTK_SETTINGS"

GTK4_SETTINGS="$HOME/.config/gtk-4.0/settings.ini"
mkdir -p "$(dirname "$GTK4_SETTINGS")"
cp "$GTK_SETTINGS" "$GTK4_SETTINGS"

if command -v gsettings &> /dev/null; then
    gsettings set org.gnome.desktop.interface cursor-theme "${CURSOR_THEME}" 2>/dev/null || true
    gsettings set org.gnome.desktop.interface cursor-size ${CURSOR_SIZE} 2>/dev/null || true
fi

PROFILE_FILE="$HOME/.profile"
if [ -f "$HOME/.bash_profile" ]; then
    PROFILE_FILE="$HOME/.bash_profile"
fi

sed -i '/XCURSOR_THEME/d' "$PROFILE_FILE"
sed -i '/XCURSOR_SIZE/d' "$PROFILE_FILE"
echo "export XCURSOR_THEME=${CURSOR_THEME}" >> "$PROFILE_FILE"
echo "export XCURSOR_SIZE=${CURSOR_SIZE}" >> "$PROFILE_FILE"
