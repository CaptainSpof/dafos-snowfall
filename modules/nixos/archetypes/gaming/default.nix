{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.archetypes.gaming;
in
{
  options.dafos.archetypes.gaming = with types; {
    enable = mkBoolOpt false "Whether or not to enable the gaming archetype.";
  };

  config = mkIf cfg.enable {
    dafos.suites = {
      common = enabled;
      desktop = enabled;
      games = enabled;
      social = enabled;
      media = enabled;
    };
  };
}
