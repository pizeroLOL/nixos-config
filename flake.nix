{
  description = "Pizero's NixOS Flake";

  inputs = {
    # os
    nixpkgs.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git/?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-on-droid
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/testing";
      inputs.nixpkgs.follows = "nixpkgs-stable";
      inputs.home-manager.follows = "home-manager-stable";
    };
  };

  outputs =
    all@{
      # nur,
      nixpkgs,
      nixos-cosmic,
      home-manager,
      nixpkgs-stable,
      nix-on-droid,
      home-manager-stable,
      ...
    }:
    {
      # Used with `nixos-rebuild --flake .#<hostname>`
      # nixosConfigurations."<hostname>".config.system.build.toplevel must be a derivation
      nixosConfigurations."nixos-to-go" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # nur.nixosModules.nur
          nixos-cosmic.nixosModules.default
          ./hosts/nixos-to-go/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.pizero = import ./home/nixos-to-go.nix;
            home-manager.backupFileExtension = "bku";
          }
        ];
      };

      nixOnDroidConfigurations.pizero-phone = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs-stable {
          system = "aarch64-linux";
          overlays = [
            nix-on-droid.overlays.default
            # add other overlays
          ];
        };

        modules = [
          ./hosts/nix-on-droid/default.nix
          {
            home-manager = {
              backupFileExtension = "hm-bak";
              useGlobalPkgs = true;
              config = ./home/nix-on-droid.nix;
            };
          }
        ];
        home-manager-path = home-manager-stable.outPath;
      };
    };
}
