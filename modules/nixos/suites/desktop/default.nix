{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.suites.desktop;
in
{
  options.dafos.suites.desktop = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    dafos = {
      desktop = {
        gnome = enabled;

        addons = { wallpapers = enabled; };
      };

      apps = {
        _1password = enabled;
        firefox = enabled;
        vlc = enabled;
        logseq = enabled;
        pocketcasts = enabled;
        yt-music = enabled;
        ardour = enabled;
        gparted = enabled;
      };
    };
  };
}
