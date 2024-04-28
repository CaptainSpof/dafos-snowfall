{ config, pkgs, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.hardware.sensors;
in
{
  options.dafos.hardware.sensors = with types; {
    enable = mkBoolOpt false "Whether or not to enable sensors support.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lm_sensors
    ];

    programs.coolercontrol.enable = true;
  };
}
