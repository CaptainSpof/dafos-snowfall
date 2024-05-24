{ config, lib, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.cli-apps.fish;
in
{
  options.${namespace}.cli-apps.fish = with types; {
    enable = mkBoolOpt false "Whether or not to enable Fish.";
  };

  config = mkIf cfg.enable {
    programs.fish.enable = true;
  };
}
