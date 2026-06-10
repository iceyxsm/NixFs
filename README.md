# NixFS - NixOS Btrfs + KDE Plasma 6

## Setup

1. Install NixOS with btrfs (GUI installer)
2. Clone this repo:
   ```bash
   git clone https://github.com/iceyxsm/NixFs.git
   cd NixFs
   ```
3. Run setup:
   ```bash
   ./scripts/setup.sh
   ```
4. Reboot

Auto-detects your username and hostname. Imports hardware config from `/etc/nixos/hardware-configuration.nix`.

## What's included

### Desktop
- KDE Plasma 6 on Wayland (SDDM)
- Smart Video Wallpaper Reborn (desktop + lock screen)
- Plasma-Manager for declarative KDE config
- Starship prompt, zoxide, direnv, fzf

### Dev Tools
- Rust (rustc, cargo, cargo-binstall, rust-analyzer)
- Python (python3, pip, virtualenv, uv)
- Node.js (nodejs, pnpm, typescript)
- Deno, Go (gopls), Java (JDK, Maven, Gradle)
- C/C++ (gcc, cmake, mold, ccache, sccache)

### CLI Tools
- ripgrep, fd, bat, eza, fzf, zoxide
- btop, dust, lazygit, just, tldr, tmux
- git, curl, wget, rsync, jq, yq, strace

### System
- Btrfs with zstd compression + auto-scrub + dedup
- Memory tuning (swappiness=100, zswap zstd)
- AI workload cgroup isolation
- Fail2ban, earlyoom, DNS-over-TLS
- Bootloader: 2 generations, editor enabled

### Hardware
- TP-Link TX50UH WiFi (RTL8832CU usb_modeswitch)
- Bluetooth + Blueman
- AMD microcode
- PipeWire audio

### Containers
- Podman (docker compat, rootless)

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
│   ├── users.nix
│   ├── dev.nix
│   ├── cli-tools.nix
│   ├── containers.nix
│   ├── security.nix
│   └── system-tuning.nix
├── home/
│   ├── default.nix
│   ├── plasma.nix
│   └── shell.nix
└── scripts/
    ├── setup.sh
    └── btrfs-snapshot.sh
```

## Scripts

- `./scripts/setup.sh` - Full setup (rebuild + wallpapers + video plugin)
- `./scripts/btrfs-snapshot.sh` - Btrfs snapshot helper
