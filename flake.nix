{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    eca = {
      url = "github:editor-code-assistant/eca";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lofi = {
      url = "github:ochsnerd/lo-fi-mockups";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      treefmt-nix,
      deploy-rs,
      disko,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      system = "x86_64-linux";

      pkgs = nixpkgs.legacyPackages.${system};

      treefmtEval = treefmt-nix.lib.evalModule pkgs {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
        programs.shfmt.enable = true;
        programs.prettier.enable = true;
      };
    in
    {
      # `nix fmt`
      formatter.${system} = treefmtEval.config.build.wrapper;

      # `nix flake check`
      checks.${system} = {
        # make formatting fail `nix flake check`
        formatting = treefmtEval.config.build.check self;
      }
      // deploy-rs.lib.${system}.deployChecks self.deploy;

      overlays = import ./overlays { inherit inputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      # `deploy .#hetzner`
      deploy.nodes.hetzner = {
        hostname = "128.140.72.209";
        profiles.system = {
          sshUser = "david";
          user = "root";
          path = deploy-rs.lib.${system}.activate.nixos self.nixosConfigurations.hetzner;
          magicRollback = true;
          autoRollback = true;
        };
      };

      nixosConfigurations = {
        hetzner = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            disko.nixosModules.disko
            ./hetzner/nixos/configuration.nix
          ];
        };
        pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./pc/nixos/configuration.nix
            ./pc/nixos/hardware-configuration.nix
          ];
        };
        framework = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./framework/nixos/configuration.nix
            ./framework/nixos/hardware-configuration.nix
            ./framework/nixos/framework.nix
          ];
        };
      };

      apps.${system}.deploy = {
        type = "app";
        meta.description = "Deploy the hetzner node with deploy-rs";
        program = pkgs.lib.getExe (
          pkgs.writeShellApplication {
            name = "deploy-hetzner";
            runtimeInputs = [ deploy-rs.packages.${system}.default ];
            text = ''
              exec deploy .#hetzner "$@"
            '';
          }
        );
      };
    };
}
