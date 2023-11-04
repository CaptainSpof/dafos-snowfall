{ lib, config, pkgs, ... }:

let
  cfg = config.dafos.services.readarr;

  username = config.dafos.vars.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [ ../../../vars.nix ];

  options.dafos.services.readarr = {
    enable = mkEnableOption "Whether or not to configure Readarr";
  };

  config = mkIf cfg.enable {
    services.readarr = {
      enable = true;
      user = username;
      openFirewall = true;
    };
  };
}
