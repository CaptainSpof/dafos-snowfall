{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:

with lib;
with lib.${namespace};
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.desktop.addons.wofi;
in
{
  options.${namespace}.desktop.addons.wofi = {
    enable = mkBoolOpt false "Whether to enable the Wofi in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wofi
      wofi-emoji
    ];

    # config -> .config/wofi/config
    # css -> .config/wofi/style.css
    # colors -> $XDG_CACHE_HOME/wal/colors
    dafos.home.configFile."wofi/config".source = ./config;
    dafos.home.configFile."wofi/style.css".source = ./style.css;
  };
}
