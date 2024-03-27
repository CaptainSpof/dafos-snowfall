{ lib, config, ... }:

let
  cfg = config.dafos.services.mealie;

  username = config.dafos.vars.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [ ../../../vars.nix ];

  options.dafos.services.mealie = {
    enable = mkEnableOption "Whether or not to configure Mealie";
  };

  config = mkIf cfg.enable {
    services.mealie = {
      enable = true;
    };
  };
}
