{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.desktop.addons.wofi;
in
{
  options.dafos.desktop.addons.wofi = with types; {
    enable =
      mkBoolOpt false "Whether to enable the Wofi in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ wofi wofi-emoji ];

    # config -> .config/wofi/config
    # css -> .config/wofi/style.css
    # colors -> $XDG_CACHE_HOME/wal/colors
    # dafos.home.configFile."foot/foot.ini".source = ./foot.ini;
    dafos.home.configFile."wofi/config".source = ./config;
    dafos.home.configFile."wofi/style.css".source = ./style.css;
  };
}
