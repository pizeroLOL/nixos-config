{
  description = "Pizero's NixOS Flake";

  inputs = {
    # os
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixos-cosmic = {
    #   url = "github:lilyinstarlight/nixos-cosmic";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # # nix-on-droid
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/testing";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      # nur,
      nixpkgs,
      # nixos-cosmic,
      home-manager,
      nix-on-droid,
      ...
    }:
    {
      # Used with `nixos-rebuild --flake .#<hostname>`
      # nixosConfigurations."<hostname>".config.system.build.toplevel must be a derivation
      nixosConfigurations."nixos-to-go" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          # nur.nixosModules.nur
          # nixos-cosmic.nixosModules.default
          # {
          #   nixpkgs.buildPlatform = { system = "x86_64-linux"; };
          #   nixpkgs.hostPlatform = {
          #     gcc.arch = "skylake";
          #     gcc.tune = "skylake";
          #     system = "x86_64-linux";
          #   };
          #   nix.settings.system-features = [
          #     "nixos-test"
          #     "benchmark"
          #     "big-parallel"
          #     "kvm"
          #     # "gccarch-skylake"
          #     # "gcctune-skylake"
          #     "recursive-nix"
          #   ];
          # }
          ./hosts/nixos-to-go/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.pizero = import ./home/nixos-to-go.nix;
              backupFileExtension = "bku";
            };
          }
        ];
      };

      nixOnDroidConfigurations.pizero-phone = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs {
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
        home-manager-path = home-manager.outPath;
      };
    };
}
