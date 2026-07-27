#!/usr/bin/env bash
set -euo pipefail

BUILD_DIR="$HOME/build"
SWAYFX_DIR="$BUILD_DIR/swayfx"

echo "==> Instalando dependencias..."

sudo apt update

sudo apt install -y \
    meson \
    ninja-build \
    pkg-config \
    cmake \
    git \
    scdoc \
    wayland-protocols \
    libwayland-dev \
    libpcre2-dev \
    libjson-c-dev \
    libpango1.0-dev \
    libcairo2-dev \
    libgdk-pixbuf-2.0-dev \
    libdrm-dev \
    libgbm-dev \
    libinput-dev \
    libseat-dev \
    libxkbcommon-dev \
    libxcb-dri3-dev \
    libxcb-present-dev \
    libxcb-res0-dev \
    libxcb-render-util0-dev \
    libxcb-ewmh-dev \
    libxcb-icccm4-dev \
    libliftoff-dev \
    libdisplay-info-dev \
    liblcms2-dev \
    libpixman-1-dev \
    libgles2-mesa-dev \
    hwdata \
    libudev-dev

echo "==> Preparando entorno..."

rm -rf "$SWAYFX_DIR"
mkdir -p "$BUILD_DIR"

git clone https://github.com/WillPower3309/swayfx.git "$SWAYFX_DIR"

cd "$SWAYFX_DIR"
git checkout 0.5.3

mkdir -p subprojects
cd subprojects

echo "==> Descargando SceneFX..."

git clone https://github.com/wlrfx/scenefx.git
cd scenefx
git checkout 0.4.1
cd ..

echo "==> Descargando wlroots..."

git clone https://gitlab.freedesktop.org/wlroots/wlroots.git
cd wlroots
git checkout 0.19.0

cd ../..

echo "==> Compilando..."

meson setup build
ninja -C build

echo "==> Instalando..."

sudo ninja -C build install

sudo ldconfig

echo
echo "Instalación completada."
echo

sway --version
