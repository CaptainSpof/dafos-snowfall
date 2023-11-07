{ lib, config, ... }:

let
  cfg = config.dafos.services.sonarr;

  username = config.dafos.vars.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [ ../../../vars.nix ];

  options.dafos.services.sonarr = {
    enable = mkEnableOption "Whether or not to configure Sonarr";
  };

  config = mkIf cfg.enable {
    services.sonarr = {
      enable = true;
      user = username;
      openFirewall = true;
    };
  };
}
