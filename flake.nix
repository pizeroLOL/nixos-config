{
  description = "Pizero's NixOS Flake";

  # The nixos-20.09 branch of the NixOS/nixpkgs repository on GitHub.
  # inputs.nixpkgsGitHubBranch.url = "github:NixOS/nixpkgs/nixos-23.11";
  # inputs.nixpkgsGitHubBranch.url =
  #   "git+https://github.com/NixOS/nixpkgs?ref=nixos-23.11";
  inputs.nixpkgs.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git/?ref=nixos-unstable";

  # inputs.nur.url = "github:nix-community/NUR";

  # nixpkgs.url = "git+https://kkgithub.com/nixpkgs?ref=/nixos-23.11";
  inputs.home-manager.url = "git+https://kkgithub.com/nix-community/home-manager";
  # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  # inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  # # A GitHub repository.
  # inputs.import-cargo = {
  #   type = "github";
  #   owner = "edolstra";
  #   repo = "import-cargo";
  # };

  # Transitive inputs can be overridden from a flake.nix file. For example, the following overrides the nixpkgs input of the nixops input:
  # inputs.nixops.inputs.nixpkgs = {
  #   type = "github";
  #   owner = "NixOS";
  #   repo = "nixpkgs";
  # };
  inputs.nixops.url = "nixops";
  inputs.dwarffs.url = "dwarffs";
  inputs.dwarffs.inputs.nixpkgs.follows = "nixpkgs";

  outputs =
    all@{
      self,
      # nur,
      nixpkgs,
      home-manager,
      ...
    }:
    {
      # Used with `nixos-rebuild --flake .#<hostname>`
      # nixosConfigurations."<hostname>".config.system.build.toplevel must be a derivation
      # nixosConfigurations = {
      nixosConfigurations."nixos-test" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ { boot.isContainer = true; } ];
      };
      nixosConfigurations."nixos-to-go" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # nur.nixosModules.nur
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
      # };
      # Utilized by `nix develop .#<name>`
      devShells.x86_64-linux.example = self.devShell.x86_64-linux;

      # Utilized by Hydra build jobs
      hydraJobs.example.x86_64-linux = self.defaultPackage.x86_64-linux;

      # Utilized by `nix flake init -t <flake>#<name>`
      #templates.example = self.defaultTemplate;
    };
}
