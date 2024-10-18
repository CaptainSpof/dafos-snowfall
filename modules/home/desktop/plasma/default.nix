{
  config,
  lib,
  namespace,
  pkgs,
  inputs,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.desktop.plasma;

  defaultPackages = with pkgs; [
    # Apps
    kdePackages.kalk
    kdePackages.kcolorchooser
    kdePackages.kweather
    kdePackages.merkuro
    kdePackages.koi
    inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
    # Themes
    dafos.kde-warm-eyes
    dafos.leaf-kde
    dafos.lightly-qt6
    dafos.plasma-applet-netspeed-widget
    gruvbox-gtk-theme
    kde-gruvbox
    papirus-icon-theme
    # Utils
    kdotool
    wl-clipboard
  ];
in
{
  options.${namespace}.desktop.plasma = {
    enable = mkBoolOpt false "Whether or not to use Plasma as the desktop environment.";

    touchScreen = mkBoolOpt false "Whether or not to enable touch screen capabilities.";
    themeSwitcher = mkBoolOpt false "Whether or not to enable theme switcher service.";
  };

  config = mkIf cfg.enable {
    dafos = {
      desktop.addons = {
        electron-support = enabled;
      };
      services.koi.enable = cfg.themeSwitcher;
    };

    programs.plasma.enable = true;

    home.packages =
      with pkgs;
      (lib.optionals cfg.touchScreen [
        # Virtual keyboard
        maliit-framework
        maliit-keyboard
      ])
      ++ defaultPackages;
  };
}
