# NixFS - NixOS Btrfs + KDE Plasma 6

## Setup

1. Install NixOS with btrfs
2. Clone this repo
3. `./scripts/switch.sh`

Auto-detects your username and hostname. Imports hardware config from the installer.

## What's included

Your current system, but on btrfs with flakes:

- KDE Plasma 6 on Wayland (SDDM)
- PipeWire audio
- Firefox, Kate, wofi, mpvpaper
- TP-Link TX50UH usb_modeswitch
- Printing (CUPS)
- Plasma-Manager for KDE config
- Auto garbage collection

## Structure

```
NixFS/
├── flake.nix
├── hosts/btrfs/
│   └── configuration.nix
├── modules/
│   ├── base.nix
│   ├── kde-plasma.nix
│   ├── networking.nix
│   ├── audio.nix
│   ├── bluetooth.nix
│   └── users.nix
├── home/
│   ├── default.nix
│   └── plasma.nix
└── scripts/
    ├── switch.sh
    └── btrfs-snapshot.sh
```
