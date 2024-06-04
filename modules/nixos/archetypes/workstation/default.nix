{ config, lib, namespace, ... }:
with lib;
with lib.${namespace};
let cfg = config.${namespace}.archetypes.workstation;
in
{
  options.${namespace}.archetypes.workstation = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable the workstation archetype.";
  };

  config = mkIf cfg.enable {
    dafos = {

      services = {
        logiops = enabled;
      };

      suites = {
        common = enabled;
        desktop = enabled;
        development = enabled;
        art = enabled;
        video = enabled;
        social = enabled;
        media = enabled;
        music = enabled;
      };

      tools = {
        appimage-run = enabled;
      };
    };
  };
}
