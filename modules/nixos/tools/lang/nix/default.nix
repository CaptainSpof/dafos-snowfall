{ config, pkgs, lib, namespace, ... }:

with lib;
with lib.${namespace};
let cfg = config.${namespace}.tools.lang.nix;
in {
  options.${namespace}.tools.lang.nix = with types; {
    enable = mkBoolOpt false "Whether or not to install and configure git";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      deadnix
      nixfmt-classic
      nixpkgs-fmt
      nixpkgs-hammering
      nixpkgs-lint-community
      nixpkgs-review
    ];
  };
}
