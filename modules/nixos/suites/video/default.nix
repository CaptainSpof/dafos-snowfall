{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.suites.video;
in
{
  options.dafos.suites.video = with types; {
    enable = mkBoolOpt false "Whether or not to enable video configuration.";
    editing.enable = mkBoolOpt false "Whether or not to enable video editing configuration.";
    recording.enable = mkBoolOpt false "Whether or not to enable video recording configuration.";
  };

  config = mkIf cfg.enable {
    dafos = {
      apps = {
        freetube = disabled;
        mpv = enabled;
        obs.enable = cfg.recording.enable;
        pitivi.enable = cfg.editing.enable;
        vlc = enabled;
      };
    };

    environment.systemPackages = [
      pkgs.yt-dlp
    ];
  };
}
