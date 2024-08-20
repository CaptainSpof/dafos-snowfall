{ config, lib, namespace, ... }:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) enabled mkBoolOpt;

  cfg = config.${namespace}.archetypes.gaming;
in
{
  options.${namespace}.archetypes.gaming = {
    enable = mkBoolOpt false "Whether or not to enable the gaming archetype.";
  };

  config = mkIf cfg.enable {
    dafos.suites = {
      common = enabled;
      desktop = enabled;
      games = enabled;
    };
  };
}
