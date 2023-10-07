{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.apps.discord;
  discord = lib.replugged.makeDiscordPlugged {
    inherit pkgs;

    # This is currently broken, but could speed up Discord startup in the future.
    withOpenAsar = false;

    plugins = {
      inherit (inputs) discord-tweaks;
    };

    themes = {
      inherit (inputs) discord-nord-theme;
    };
  };
in
{
  options.dafos.apps.discord = with types; {
    enable = mkBoolOpt false "Whether or not to enable Discord.";
    canary.enable = mkBoolOpt false "Whether or not to enable Discord Canary.";
    chromium.enable = mkBoolOpt false
      "Whether or not to enable the Chromium version of Discord.";
    firefox.enable = mkBoolOpt false
      "Whether or not to enable the Firefox version of Discord.";
    native.enable = mkBoolOpt false "Whether or not to enable the native version of Discord.";
  };

  config = mkIf (cfg.enable or cfg.chromium.enable) {
    environment.systemPackages =
      lib.optional cfg.enable discord
      ++ lib.optional cfg.canary.enable pkgs.dafos.discord
      ++ lib.optional cfg.chromium.enable pkgs.dafos.discord-chromium
      ++ lib.optional cfg.firefox.enable pkgs.dafos.discord-firefox
      ++ lib.optional cfg.native.enable pkgs.discord;
  };
}
