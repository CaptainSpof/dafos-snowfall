{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.apps.cadence;
in
{
  options.dafos.apps.cadence = with types; {
    enable = mkBoolOpt false "Whether or not to enable Cadence.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ cadence ]; };
}
