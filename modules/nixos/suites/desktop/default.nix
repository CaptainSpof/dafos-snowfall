{ config, lib, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.desktop;
in
{
  options.${namespace}.suites.desktop = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    dafos = {
      desktop = {
        gnome = disabled;
        plasma = {
          enable = true;
          panels.enable = true;
        };
        addons = { wallpapers = enabled; };
      };

      apps = {
        gparted = enabled;
      };
    };
  };
}
