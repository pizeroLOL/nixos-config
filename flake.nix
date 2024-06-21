{
  description = "Pizero's NixOS Flake";

  inputs.nixpkgs.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git/?ref=nixos-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.nixos-cosmic = {
    url = "github:lilyinstarlight/nixos-cosmic";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  # inputs.nixops.url = "nixops";
  # inputs.dwarffs.url = "dwarffs";
  # inputs.dwarffs.inputs.nixpkgs.follows = "nixpkgs";

  outputs =
    all@{
      # nur,
      nixpkgs,
      nixos-cosmic,
      home-manager,
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
            home-manager.users.pizero = import ./home/default.nix;
            home-manager.backupFileExtension = "bku";
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
}
