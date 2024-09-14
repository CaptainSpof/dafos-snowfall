{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.desktop.plasma;

  defaultPackages = with pkgs; [
    # Apps
    kdePackages.kweather
    kdePackages.merkuro
    kdePackages.kcolorchooser
    # Themes
    dafos.kde-warm-eyes
    dafos.leaf-kde
    dafos.lightly-qt6
    dafos.plasma-applet-netspeed-widget
    dafos.koi
    gruvbox-gtk-theme
    kde-gruvbox
    papirus-nord
    # Utils
    kdotool
    wl-clipboard
  ];
in
{
  options.${namespace}.desktop.plasma = {
    enable = mkBoolOpt false "Whether or not to use Plasma as the desktop environment.";

    touchScreen = mkBoolOpt false "Whether or not to enable touch screen capabilities.";
  };

  config = mkIf cfg.enable {
    dafos.desktop.addons = {
      electron-support = enabled;
    };

    programs.plasma.enable = true;

    home.packages =
      with pkgs;
      [ (hiPrio dafos.xdg-open-with-portal) ]
      ++ (lib.optionals cfg.touchScreen [
        # Virtual keyboard
        maliit-framework
        maliit-keyboard
      ])
      ++ defaultPackages;
  };
}
