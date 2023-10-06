{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.desktop.addons.rofi;
in
{
  options.dafos.desktop.addons.rofi = with types; {
    enable =
      mkBoolOpt false "Whether to enable Rofi in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ rofi ];

    dafos.home.configFile."rofi/config.rasi".source = ./config.rasi;
  };
}
