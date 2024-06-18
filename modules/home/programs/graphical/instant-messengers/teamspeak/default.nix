{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.programs.graphical.instant-messengers.teamspeak;
in
{
  options.${namespace}.programs.graphical.instant-messengers.teamspeak = {
    enable = mkBoolOpt false "Whether or not to enable teamspeak.";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.teamspeak5_client ];
  };
}
