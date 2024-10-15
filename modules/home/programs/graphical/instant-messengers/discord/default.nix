{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.instant-messengers.discord;
in
{
  options.${namespace}.programs.graphical.instant-messengers.discord = {
    enable = mkBoolOpt false "Whether or not to enable Discord.";
    canary.enable = mkBoolOpt false "Whether or not to enable Discord Canary.";
    vesktop.enable = mkBoolOpt true "Whether or not to enable Discord Vesktop.";
    firefox.enable = mkBoolOpt false "Whether or not to enable the Firefox version of Discord.";
  };

  config = mkIf cfg.enable {

    # FIXME
    # lib.optional cfg.enable pkgs.discord
    home.packages =
      lib.optional cfg.canary.enable pkgs.dafos.discord
      ++ lib.optional cfg.vesktop.enable pkgs.vesktop
      ++ lib.optional cfg.firefox.enable pkgs.dafos.discord-firefox;
  };
}
