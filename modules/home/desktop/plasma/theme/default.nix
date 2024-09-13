{
  config,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;
  inherit (config.${namespace}.user) home;
  inherit (config.${namespace}.user.font) ui mono;

  cfg = config.${namespace}.desktop.plasma.theme;

  defaultFont = {
    family = ui;
    pointSize = 10;
  };
in
{
  options.${namespace}.desktop.plasma.theme = {
    enable = mkBoolOpt false "Whether or not to configure plasma theme.";
  };

  config = mkIf cfg.enable {
    programs.plasma = {
      fonts = {
        general = defaultFont;
        fixedWidth = defaultFont // {
          family = mono;
        };
        small = defaultFont // {
          pointSize = 8;
        };
        toolbar = defaultFont;
        menu = defaultFont;
        windowTitle = defaultFont;
      };

      workspace = {
        clickItemTo = "open";
        colorScheme = "Gruvbox";
        cursor.theme = "breeze_cursors";
        soundTheme = "ocean";
        tooltipDelay = 5;
        theme = "breeze-dark";
        wallpaperSlideShow = {
          path = "${home}/Pictures/wallpapers/";
          interval = 300;
        };
        windowDecorations = {
          library = "org.kde.lightly";
          theme = "Lightly";
        };
      };

      configFile = {
        kdeglobals.KDE.widgetStyle = "Lightly";
      };
    };
  };
}
