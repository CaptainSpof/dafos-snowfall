{ lib, config, namespace, ... }:

let
  cfg = config.${namespace}.services.prowlarr;

  inherit (lib) mkEnableOption mkIf;
in {
  options.${namespace}.services.prowlarr = {
    enable = mkEnableOption "Whether or not to configure Prowlarr";
  };

  config = mkIf cfg.enable {
    services.prowlarr = {
      enable = true;
      openFirewall = true;
    };
  };
}
