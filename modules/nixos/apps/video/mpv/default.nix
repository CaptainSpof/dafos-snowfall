{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.apps.mpv;
in
{
  options.dafos.apps.mpv = with types; {
    enable = mkBoolOpt false "Whether or not to enable mpv.";
  };

  config = mkIf cfg.enable { environment.systemPackages = with pkgs; [ mpv ]; };
}
