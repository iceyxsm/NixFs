{ config, pkgs, ... }:

{
  # Dev languages & tools
  environment.systemPackages = with pkgs; [
    # Rust
    rustc
    cargo
    cargo-binstall
    rust-analyzer

    # Python
    python3
    python3Packages.pip
    python3Packages.virtualenv
    uv

    # Node.js
    nodejs
    nodePackages.pnpm
    nodePackages.typescript
    nodePackages.typescript-language-server

    # Deno
    deno

    # Go
    go
    gopls

    # Java
    jdk
    maven
    gradle

    # Build tools
    gcc
    gnumake
    cmake
    pkg-config
    openssl

    # Caching / linking
    ccache
    mold
    sccache

    # Nix dev
    nil
    nixd
  ];

  # ccache for faster rebuilds
  programs.ccache.enable = true;
}
