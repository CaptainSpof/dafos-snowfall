{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.suites.music;
in
{
  options.dafos.suites.music = with types; {
    enable = mkBoolOpt false "Whether or not to enable music configuration.";
    mixing.enable = mkBoolOpt false "Whether or not to enable music mixing configuration.";
  };

  config = mkIf cfg.enable {
    dafos = {
      apps = {
        amberol = enabled;
        ardour.enable = cfg.mixing.enable;
        cadence = enabled;
        pocketcasts = enabled;
        yt-music = enabled;
      };
    };
  };
}
