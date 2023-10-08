{ config, lib, ... }:
with lib;
with lib.dafos;
let cfg = config.dafos.archetypes.workstation;
in
{
  options.dafos.archetypes.workstation = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable the workstation archetype.";
  };

  config = mkIf cfg.enable {
    dafos = {

      services = {
        logiops = enabled;
        espanso = enabled;
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
