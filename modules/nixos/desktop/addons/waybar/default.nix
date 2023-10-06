{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.desktop.addons.waybar;
in
{
  options.dafos.desktop.addons.waybar = with types; {
    enable =
      mkBoolOpt false "Whether to enable Waybar in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ waybar ];

    dafos.home.configFile."waybar/config".source = ./config;
    dafos.home.configFile."waybar/style.css".source = ./style.css;
  };
}
