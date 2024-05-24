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
        plasma = enabled;
        addons = { wallpapers = enabled; };
      };

      apps = {
        firefox = enabled;
        gparted = enabled;
      };
    };
  };
}
