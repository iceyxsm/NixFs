#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
HOSTNAME=$(cat /etc/hostname)
GDRIVE_FOLDER="https://drive.google.com/drive/folders/1oS6aUxoW6DGoqzu_S3pVBlgicGPgIoYq"
WALLPAPER_DIR="$HOME/Videos/wallpapers"
PLUGIN_DIR="$HOME/.local/share/plasma/wallpapers/luisbocanegra.smart.video.wallpaper.reborn"

echo "=== NixFS Setup ==="
echo ""

# 1. Apply NixOS config
echo "[1/4] Applying NixOS configuration..."
sudo nixos-rebuild switch --impure --flake "$SCRIPT_DIR#${HOSTNAME}"

# 2. Download wallpapers
echo ""
echo "[2/4] Downloading live wallpapers..."
mkdir -p "$WALLPAPER_DIR"
nix-shell -p python3Packages.gdown --run "gdown --folder '$GDRIVE_FOLDER' -O '$WALLPAPER_DIR' --remaining-ok --no-cookies" 2>/dev/null

# 3. Install Smart Video Wallpaper Reborn
echo ""
echo "[3/4] Installing Smart Video Wallpaper Reborn..."
if [ ! -d "$PLUGIN_DIR" ]; then
    TMPDIR=$(mktemp -d)
    cd "$TMPDIR"
    git clone https://github.com/luisbocanegra/plasma-smart-video-wallpaper-reborn.git
    cd plasma-smart-video-wallpaper-reborn
    nix-shell -p git gcc cmake kdePackages.extra-cmake-modules kdePackages.kpackage kdePackages.libplasma kdePackages.qtmultimedia --run "cmake -B build -S . && cmake --build build && cmake --install build --prefix ~/.local"
    cd "$SCRIPT_DIR"
    rm -rf "$TMPDIR"
    echo "  Plugin installed."
else
    echo "  Plugin already installed."
fi

# 4. Configure desktop + lock screen wallpaper
FIRST_VIDEO=$(find "$WALLPAPER_DIR" -type f \( -iname "*.mp4" -o -iname "*.webm" \) 2>/dev/null | head -n1)
if [ -n "$FIRST_VIDEO" ]; then
    echo ""
    echo "[4/4] Setting wallpaper to: $(basename "$FIRST_VIDEO")"

    # Desktop wallpaper
    DESKTOP_CFG="$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"
    if [ -f "$DESKTOP_CFG" ]; then
        sed -i "s|VideoUrls=.*|VideoUrls=$FIRST_VIDEO|g" "$DESKTOP_CFG" 2>/dev/null || true
    fi

    # Lock screen wallpaper
    LOCK_CFG="$HOME/.config/kscreenlockerrc"
    if [ -f "$LOCK_CFG" ]; then
        sed -i "s|VideoUrls=.*|VideoUrls=$FIRST_VIDEO|g" "$LOCK_CFG" 2>/dev/null || true
    else
        mkdir -p "$HOME/.config"
        cat > "$LOCK_CFG" << EOF
[Greeter]
WallpaperTheme=luisbocanegra.smart.video.wallpaper.reborn

[Greeter][Wallpapers][luisbocanegra.smart.video.wallpaper.reborn]
VideoUrls=$FIRST_VIDEO
EOF
    fi
    echo "  Desktop + lock screen configured."
else
    echo ""
    echo "[4/4] No videos found, skipping wallpaper setup."
fi

echo ""
echo "=== Setup Complete ==="
echo "Wallpapers: $WALLPAPER_DIR"
echo "Plugin: Smart Video Wallpaper Reborn"
echo "Desktop + Lock screen: configured"
