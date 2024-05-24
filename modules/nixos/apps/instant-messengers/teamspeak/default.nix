{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.teamspeak;
in {
  options.${namespace}.apps.teamspeak = {
    enable = mkBoolOpt false "Whether or not to enable TeamSpeak.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.teamspeak5_client ];
  };
}
