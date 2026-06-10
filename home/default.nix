{ config, pkgs, username, ... }:

{
  imports = [
    ./plasma.nix
    ./shell.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Add your user-specific packages here
  ];
}
