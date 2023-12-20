{ lib, config, ... }:

let
  cfg = config.dafos.services.prowlarr;

  username = config.dafos.vars.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [ ../../../vars.nix ];

  options.dafos.services.prowlarr = {
    enable = mkEnableOption "Whether or not to configure Prowlarr";
  };

  config = mkIf cfg.enable {
    services.prowlarr = {
      enable = true;
      openFirewall = true;
    };
  };
}
