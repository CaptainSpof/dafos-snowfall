{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.apps.amberol;
in
{
  options.dafos.apps.amberol = with types; {
    enable = mkBoolOpt false "Whether or not to enable Amberol.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ amberol ]; };
}
