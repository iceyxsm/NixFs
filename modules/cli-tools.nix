{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Search & find
    ripgrep
    fd

    # File viewers
    bat
    eza

    # System monitoring
    btop
    dust

    # Git
    git
    lazygit

    # Task runners & docs
    just
    tldr

    # Network
    xh
    wget
    curl
    rsync

    # Archive
    unzip
    p7zip

    # Misc
    jq
    yq
    watchexec
    sqlite
    file
    tree
    lsof
    strace
    opencode
    kiro-cli
    nix-output-monitor
    nix-tree
    comma
  ];
}
