{ config, pkgs, ... }:

{
  # Starship prompt
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  # Direnv
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  # FZF
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  # Zoxide
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  # Tmux
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    historyLimit = 10000;
    keyMode = "vi";
    clock24 = true;
  };

  # Bash
  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "eza --icons";
      ll = "eza -la --icons";
      cat = "bat --paging=never";
      find = "fd";
      grep = "rg";
      top = "btop";
      du = "dust";
      lg = "lazygit";
    };
    initExtra = ''
      fastfetch --logo small 2>/dev/null || true
    '';
  };

  home.packages = with pkgs; [
    fastfetch
    noto-fonts
    noto-fonts-emoji
    jetbrains-mono
  ];
}
