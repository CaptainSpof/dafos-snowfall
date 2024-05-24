{ config, lib, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.music;
in
{
  options.${namespace}.suites.music = with types; {
    enable = mkBoolOpt false "Whether or not to enable music configuration.";
    mixing.enable = mkBoolOpt false "Whether or not to enable music mixing configuration.";
  };

  config = mkIf cfg.enable {
    dafos = {
      apps = {
        amberol = enabled;
        ardour.enable = cfg.mixing.enable;
        pocketcasts = enabled;
        yt-music = enabled;
      };
    };
  };
}
