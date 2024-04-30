{
  description = "Pizero's NixOS Flake";

  # The nixos-20.09 branch of the NixOS/nixpkgs repository on GitHub.
  # inputs.nixpkgsGitHubBranch.url = "github:NixOS/nixpkgs/nixos-23.11";
  # inputs.nixpkgsGitHubBranch.url =
  #   "git+https://github.com/NixOS/nixpkgs?ref=nixos-23.11";
  inputs.nixpkgs.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git/?ref=nixos-23.11";
  # nixpkgs.url = "git+https://hub.nuaa.cf/nixpkgs?ref=/nixos-23.11";
  inputs.home-manager.url = "git+https://hub.nuaa.cf/nix-community/home-manager";
  # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  # inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  # # A GitHub repository.
  # inputs.import-cargo = {
  #   type = "github";
  #   owner = "edolstra";
  #   repo = "import-cargo";
  # };

  # Inputs as attrsets.
  # An indirection through the flake registry.
  # inputs.nixpkgsIndirect = {
  #   type = "indirect";
  #   id = "nixpkgs";
  # };

  # Non-flake inputs. These provide a variable of type path.
  #inputs.grcov = {
  #  type = "github";
  #  owner = "mozilla";
  #  repo = "grcov";
  #  flake = false;
  #};

  # Transitive inputs can be overridden from a flake.nix file. For example, the following overrides the nixpkgs input of the nixops input:
  inputs.nixops.inputs.nixpkgs = {
    type = "github";
    owner = "NixOS";
    repo = "nixpkgs";
  };

  # It is also possible to "inherit" an input from another input. This is useful to minimize
  # flake dependencies. For example, the following sets the nixpkgs input of the top-level flake
  # to be equal to the nixpkgs input of the nixops input of the top-level flake:
  # inputs.nixpkgs.url = "nixpkgs";
  inputs.nixpkgs.follows = "nixops/nixpkgs";

  # The value of the follows attribute is a sequence of input names denoting the path
  # of inputs to be followed from the root flake. Overrides and follows can be combined, e.g.
  inputs.nixops.url = "nixops";
  inputs.dwarffs.url = "dwarffs";
  inputs.dwarffs.inputs.nixpkgs.follows = "nixpkgs";

  # For more information about well-known outputs checked by `nix flake check`:
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake-check.html#evaluation-checks

  # These examples all use "x86_64-linux" as the system.
  # Please see the c-hello template for an example of how to handle multiple systems.

  outputs = all@{ self, nixpkgs, home-manager, ... }: {
    # Used with `nixos-rebuild --flake .#<hostname>`
    # nixosConfigurations."<hostname>".config.system.build.toplevel must be a derivation
    # nixosConfigurations = {
    nixosConfigurations."nixos-test" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [{ boot.isContainer = true; }];
    };
    nixosConfigurations."nixos-to-go" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/nixos-to-go/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.pizero = import ./home/default.nix;

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
