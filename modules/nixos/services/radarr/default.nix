{ lib, config, pkgs, ... }:

let
  cfg = config.dafos.services.radarr;

  username = config.dafos.vars.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [ ../../../vars.nix ];

  options.dafos.services.radarr = {
    enable = mkEnableOption "Whether or not to configure Radarr";
  };

  config = mkIf cfg.enable {
    services.radarr = {
      enable = true;
      user = username;
      openFirewall = true;
    };
  };
}
