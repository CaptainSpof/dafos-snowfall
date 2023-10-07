{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.apps.alacritty;
in
{
  options.dafos.apps.alacritty = with types; {
    enable = mkBoolOpt false "Whether or not to enable Alacritty.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ alacritty ];
  };
}
