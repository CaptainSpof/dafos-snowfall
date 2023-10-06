{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.desktop.addons.swappy;
in
{
  options.dafos.desktop.addons.swappy = with types; {
    enable =
      mkBoolOpt false "Whether to enable Swappy in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ swappy ];

    dafos.home.configFile."swappy/config".source = ./config;
    dafos.home.file."Pictures/screenshots/.keep".text = "";
  };
}
