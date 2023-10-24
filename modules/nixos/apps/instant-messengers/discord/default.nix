{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf getExe;
  inherit (lib.dafos) mkBoolOpt;

  cfg = config.dafos.apps.discord;
in {
  options.dafos.apps.discord = {
    enable = mkBoolOpt false "Whether or not to enable Discord.";
    canary.enable = mkBoolOpt false "Whether or not to enable Discord Canary.";
    firefox.enable = mkBoolOpt false
      "Whether or not to enable the Firefox version of Discord.";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = lib.optional cfg.enable pkgs.discord
      ++ lib.optional cfg.canary.enable pkgs.dafos.discord
      ++ lib.optional cfg.firefox.enable pkgs.dafos.discord-firefox;

    system.userActivationScripts = {
      postInstall = ''
        echo "Running betterdiscord install"
        source ${config.system.build.setEnvironment}
        ${getExe pkgs.betterdiscordctl} install || true
      '';
    };
  };
}
