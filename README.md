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
- Plasma-Manager (panels, fonts, effects, Super+Enter keybind)
- Fonts: noto-fonts, noto-fonts-emoji, jetbrains-mono

### Dev Tools
- Rust: rustc, cargo, cargo-binstall, rust-analyzer
- Python: python3, pip, virtualenv, uv
- Node.js: nodejs, pnpm, typescript, typescript-language-server
- Deno: deno
- Go: go, gopls
- Java: jdk, maven, gradle
- C/C++: gcc, gnumake, cmake, pkg-config, openssl
- Build caching: ccache, mold, sccache
- Nix dev: nil, nixd

### CLI Tools
- Search: ripgrep, fd, fzf, zoxide
- File viewers: bat, eza
- System: btop, dust, tree, lsof, strace, neovim
- Git: git, lazygit
- Task runner: just, tldr
- Network: xh, wget, curl, rsync
- Archive: unzip, p7zip
- Data: jq, yq, watchexec, sqlite, file
- Nix: opencode, nix-output-monitor, nix-tree, comma
- Shell: starship, direnv, tmux, fastfetch
- KDE: kate, playerctl, wayland-utils, wl-clipboard, breeze

### System
- Btrfs with zstd compression + auto-scrub + weekly dedup (duperemove, compsize)
- Memory: swappiness=100, zswap (zstd, zsmalloc, 50%), zram (50%, zstd)
- AI workload cgroup (80% RAM)
- Garbage collection: weekly, keep 14 days

### Security
- Firewall (port 22 open)
- Fail2ban (5 retries, 24h ban, increment to 168h)
- Earlyoom (5% mem/swap threshold)
- DNS-over-TLS (Cloudflare + Quad9)

### Hardware
- TP-Link TX50UH WiFi (RTL8832CU usb_modeswitch udev rule)
- Bluetooth + Blueman
- AMD microcode
- PipeWire audio (ALSA, PulseAudio, JACK)
- Printing (CUPS)
- Playerctl (media keys)

### Containers
- Podman (docker compat, rootless)
- dive, podman-tui, docker-compose

### Networking
- NetworkManager + OpenVPN plugin
- OpenSSH server
- Avahi (mDNS)

### Boot
- systemd-boot: 2 generations, editor enabled
- Btrfs supported filesystems

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
