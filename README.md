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
- Noto Sans, Noto Emoji, JetBrains Mono fonts

### Dev Tools
- Rust: rustc, cargo, cargo-binstall, rust-analyzer
- Python: python3, pip, virtualenv, uv
- Node.js: nodejs, pnpm, typescript, typescript-language-server
- Deno
- Go: go, gopls
- Java: JDK, Maven, Gradle
- C/C++: gcc, gnumake, cmake, pkg-config, openssl
- Build caching: ccache, mold, sccache
- Nix dev: nil, nixd

### CLI Tools
- Search: ripgrep, fd, fzf, zoxide
- File viewers: bat, eza
- System: btop, dust, tree, lsof, strace
- Git: git, lazygit
- Task runner: just, tldr
- Network: xh, wget, curl, rsync
- Archive: unzip, p7zip
- Data: jq, yq, watchexec, sqlite, file
- Nix: opencode, nix-output-monitor, nix-tree, comma
- Shell: starship, direnv, tmux, fastfetch

### System
- Btrfs with zstd compression + auto-scrub + weekly dedup
- Memory tuning (swappiness=100, zswap zstd, zram 50%)
- AI workload cgroup isolation (80% RAM)
- Firewall + fail2ban + earlyoom
- DNS-over-TLS (Cloudflare + Quad9)
- Bootloader: 2 generations, editor enabled
- Garbage collection: weekly, keep 14 days

### Hardware
- TP-Link TX50UH WiFi (RTL8832CU usb_modeswitch udev rule)
- Bluetooth + Blueman
- AMD microcode
- PipeWire audio (PulseAudio + JACK compat)
- Printing (CUPS)
- Playerctl (media keys)

### Containers
- Podman (docker compat, rootless)
- dive, podman-tui, docker-compose

### Networking
- NetworkManager
- OpenVPN plugin
- OpenSSH server
- Avahi (mDNS)

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
