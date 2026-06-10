{
  description = "NixOS Btrfs + KDE Plasma 6";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, ... }:
  let
    username = builtins.getEnv "USER";
    hostname = builtins.readFile "/etc/hostname";
  in
  {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit username hostname; };
      modules = [
        /etc/nixos/hardware-configuration.nix
        ./hosts/btrfs/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit username; };
          home-manager.sharedModules = [
            plasma-manager.homeManagerModules.plasma-manager
          ];
          home-manager.users.${username} = import ./home/default.nix;
        }
      ];
    };
  };
}
