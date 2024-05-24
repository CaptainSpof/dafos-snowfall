{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.amberol;
in
{
  options.${namespace}.apps.amberol = with types; {
    enable = mkBoolOpt false "Whether or not to enable Amberol.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ amberol ]; };
}
