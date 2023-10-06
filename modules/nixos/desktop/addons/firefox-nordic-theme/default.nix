{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.desktop.addons.firefox-nordic-theme;
  profileDir = ".mozilla/firefox/${config.dafos.user.name}";
in
{
  options.dafos.desktop.addons.firefox-nordic-theme = with types; {
    enable = mkBoolOpt false "Whether to enable the Nordic theme for firefox.";
  };

  config = mkIf cfg.enable {
    dafos.apps.firefox = {
      extraConfig = builtins.readFile
        "${pkgs.dafos.firefox-nordic-theme}/configuration/user.js";
      userChrome = ''
        @import "${pkgs.dafos.firefox-nordic-theme}/userChrome.css";
      '';
    };
  };
}
