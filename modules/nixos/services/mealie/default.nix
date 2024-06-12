{ lib, config, namespace, ... }:

let
  cfg = config.${namespace}.services.mealie;

  inherit (lib) mkEnableOption mkIf;
in
{
  options.${namespace}.services.mealie = {
    enable = mkEnableOption "Whether or not to configure Mealie";
  };

  config = mkIf cfg.enable {
    services.mealie = {
      enable = true;
      settings = {
        BASE_URL = "http://localhost:9000";
      };
    };
  };
}
