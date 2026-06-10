{ config, pkgs, username, hostname, ... }:

{
  imports = [
    ../../modules/base.nix
    ../../modules/kde-plasma.nix
    ../../modules/networking.nix
    ../../modules/audio.nix
    ../../modules/bluetooth.nix
    ../../modules/users.nix
    ../../modules/dev.nix
    ../../modules/cli-tools.nix
    ../../modules/containers.nix
    ../../modules/security.nix
    ../../modules/system-tuning.nix
  ];

  boot.supportedFilesystems = [ "btrfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 2;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  system.stateVersion = "26.05";
}
