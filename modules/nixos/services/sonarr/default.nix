{ lib, config, namespace, ... }:

let
  cfg = config.${namespace}.services.sonarr;

  username = config.${namespace}.user.name;
  inherit (lib) mkEnableOption mkIf;
in {
  options.${namespace}.services.sonarr = {
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
