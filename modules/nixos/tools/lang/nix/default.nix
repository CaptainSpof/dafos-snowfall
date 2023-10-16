{ config, pkgs, lib, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.tools.lang.nix;
in {
  options.dafos.tools.lang.nix = with types; {
    enable = mkBoolOpt false "Whether or not to install and configure git";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      deadnix
      nil
      nixfmt
      nixpkgs-fmt
      nixpkgs-hammering
      nixpkgs-lint-community
      nixpkgs-review
    ];
  };
}
