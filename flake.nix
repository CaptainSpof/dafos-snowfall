{
  description = "Here lies my shipwrecks. I mean fleet of hosts.";

  inputs = {
    # NixPkgs (nixos-23.05)
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";

    # NixPkgs (nixos-unstable)
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # NixPkgs Unstable (nixos-unstable)
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nix User Repository (master)
    nur.url = "github:nix-community/NUR";

    # Flake Compat
    flake-compat.url = "github:nix-community/flake-compat";
    flake-compat.flake = false;

    # Flake Utils
    flake-utils.url = "github:numtide/flake-utils";

    # Hardware Configuration
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Generate System Images
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    # Snowfall Lib
    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    # Snowfall Flake
    snowfall-flake.url = "github:snowfallorg/flake";
    snowfall-flake.inputs.nixpkgs.follows = "nixpkgs";

    # Comma
    comma.url = "github:nix-community/comma";
    comma.inputs.nixpkgs.follows = "nixpkgs";

    # Nuenv
    nuenv.url = "github:DeterminateSystems/nuenv";

    # Plasma-Manager
    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    # Pre Commit Hooks
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks.inputs.flake-utils.follows = "flake-utils";
    pre-commit-hooks.inputs.flake-compat.follows = "flake-compat";

    # System Deployment
    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

    # Disko
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Run unpatched dynamically compiled binaries
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    # Vault Integration
    vault-service.url = "github:DeterminateSystems/nixos-vault-service";
    vault-service.inputs.nixpkgs.follows = "nixpkgs";

    bibata-cursors.url = "github:suchipi/Bibata_Cursor";
    bibata-cursors.flake = false;
  };

  outputs = inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;

        snowfall = {
          meta = {
            name = "dafos";
            title = "It ain't pretty, but it's mine.";
          };

          namespace = "dafos";
        };
      };
    in
      lib.mkFlake {
        channels-config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "openssl-1.1.1w" ];
        };

        overlays = with inputs; [
          snowfall-flake.overlays.default
          nuenv.overlays.default
          nur.overlay
        ];

        systems.modules.nixos = with inputs; [
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          nix-ld.nixosModules.nix-ld
          vault-service.nixosModules.nixos-vault-service
        ];

        systems.modules.home = with inputs; [
          plasma-manager.homeManagerModules.plasma-manager
        ];

        systems.hosts.dafoltop.modules = with inputs; [
          nixos-generators.nixosModules.all-formats
        ];

        deploy = lib.mkDeploy { inherit (inputs) self; };

        checks =
          builtins.mapAttrs
            (_system: deploy-lib:
              deploy-lib.deployChecks inputs.self.deploy)
            inputs.deploy-rs.lib;
      };
}
