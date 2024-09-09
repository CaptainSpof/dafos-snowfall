{
  config,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.desktop.plasma;
in
{
  options.${namespace}.desktop.plasma = {
    enable = mkBoolOpt false "Whether or not to use plasma as the desktop environment.";
  };

  config = mkIf cfg.enable {
    dafos.system.xkb.enable = true;

    services = {
      desktopManager.plasma6.enable = true;
      libinput.enable = true;
      xserver.enable = true;
    };

    programs.dconf.enable = true;
    programs.kdeconnect.enable = true;
  };
}
