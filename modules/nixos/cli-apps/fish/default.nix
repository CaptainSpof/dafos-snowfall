{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.cli-apps.fish;
in
{
  options.dafos.cli-apps.fish = with types; {
    enable = mkBoolOpt false "Whether or not to enable Fish.";
  };

  config = mkIf cfg.enable {
    programs.fish.enable = true;
  };
}
