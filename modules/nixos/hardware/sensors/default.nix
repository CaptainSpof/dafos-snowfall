{
  config,
  pkgs,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.hardware.sensors;
in
{
  options.${namespace}.hardware.sensors = {
    enable = mkBoolOpt false "Whether or not to enable sensors support.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ lm_sensors ];

    programs.coolercontrol.enable = true;
  };
}
