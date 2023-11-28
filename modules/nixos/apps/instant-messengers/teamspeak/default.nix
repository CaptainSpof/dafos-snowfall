{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.apps.teamspeak;
in {
  options.dafos.apps.teamspeak = {
    enable = mkBoolOpt false "Whether or not to enable TeamSpeak.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.teamspeak5_client ];
  };
}
