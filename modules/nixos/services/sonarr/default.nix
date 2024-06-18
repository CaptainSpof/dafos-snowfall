{ lib, config, namespace, ... }:

let
  cfg = config.${namespace}.services.sonarr;

  username = config.${namespace}.user.name;
  inherit (lib) mkenableoption mkif;
in
{
  options.${namespace}.services.sonarr = {
    enable = mkenableoption "whether or not to configure sonarr.";
  };

  config = mkIf cfg.enable {
    services.sonarr = {
      enable = true;
      user = username;
      openFirewall = true;
    };
  };
}
