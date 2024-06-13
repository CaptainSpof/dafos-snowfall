{ config, pkgs, lib, inputs, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.nix;

  substituters-submodule = types.submodule ({ ... }: {
    options = with types; {
      key = mkOpt (nullOr str) null "The trusted public key for this substituter.";
    };
  });
in
{
  options.${namespace}.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package = mkOpt package pkgs.nixVersions.latest "Which nix package to use.";

    default-substituter = {
      url = mkOpt str "https://cache.nixos.org" "The url for the substituter.";
      key = mkOpt str "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "The trusted public key for the substituter.";
    };

    extra-substituters = mkOpt (attrsOf substituters-submodule) {
      "https://viperml.cachix.org" = { key = "viperml.cachix.org-1:qZhKBMTfmcLL+OG6fj/hzsMEedgKvZVFRRAhq7j8Vh8="; };
    } "Extra substituters to configure.";
  };

  config = mkIf cfg.enable {
    assertions = mapAttrsToList
      (name: value: {
        assertion = value.key != null;
        message = "dafos.nix.extra-substituters.${name}.key must be set";
      })
      cfg.extra-substituters;

    environment.systemPackages = with pkgs; [
      dafos.bump
      dafos.nixos-revision
      (dafos.nixos-hosts.override {
        hosts = inputs.self.nixosConfigurations;
      })
      deploy-rs
      nix-index
      nix-init
      nix-prefetch-git
      nix-output-monitor
      # TODO: revive flake-checker
      # flake-checker
    ];

    programs.nh = {
      enable = true;
      clean.enable = false;
    };

    nix =
      let users = [ "root" config.${namespace}.user.name ] ++
                  optional config.services.hydra.enable "hydra";
      in
        {
          package = cfg.package;

          settings = {
            experimental-features = "nix-command flakes";
            http-connections = 50;
            warn-dirty = false;
            log-lines = 50;
            sandbox = "relaxed";
            auto-optimise-store = true;
            trusted-users = users;
            allowed-users = users;

            substituters =
              [ cfg.default-substituter.url ]
              ++
              (mapAttrsToList (name: _value: name) cfg.extra-substituters);
            trusted-public-keys =
              [ cfg.default-substituter.key ]
              ++
              (mapAttrsToList (_name: value: value.key) cfg.extra-substituters);

          } // (lib.optionalAttrs config.${namespace}.tools.direnv.enable {
            keep-outputs = true;
            keep-derivations = true;
          });

          gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 30d";
          };

          # flake-utils-plus
          generateRegistryFromInputs = true;
          generateNixPathFromInputs = true;
          linkInputs = true;
        };
  };
}
