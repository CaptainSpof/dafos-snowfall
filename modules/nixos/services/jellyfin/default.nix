{ lib, config, namespace, ... }:

let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.services.jellyfin;
  username = config.${namespace}.user.name;
  home = config.${namespace}.user.home;
in
{

  options.${namespace}.services.jellyfin = {
    enable = mkEnableOption "Whether or not to configure jellyfin.";
  };

  config = mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      user = username;
      openFirewall = true;
      cacheDir = "${home}/.cache/jellyfin";
    };
  };
}
