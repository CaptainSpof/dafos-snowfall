{ lib, config, pkgs, ... }:

let
  cfg = config.dafos.services.jellyfin;

  username = config.dafos.vars.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [ ../../../vars.nix ];

  options.dafos.services.jellyfin = {
    enable = mkEnableOption "Whether or not to configure Jellyfin";
  };

  config = mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      user = username;
      openFirewall = true;
    };
  };
}
