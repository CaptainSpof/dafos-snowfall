{
  config,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;
  inherit (config.${namespace}.user.location) latitude longitude;

  cfg = config.${namespace}.desktop.plasma.kwin;
in
{
  options.${namespace}.desktop.plasma.kwin = {
    enable = mkBoolOpt false "Whether or not to configure plasma kwin.";

    virtualDesktopsNames = mkOpt (types.listOf types.str) [
      "Mail"
      "Video"
      "Other"
      "Stuff"
      "Yes"
    ] "The names to give to the virtual desktops";
  };

  config = mkIf cfg.enable {
    programs.plasma = {
      kwin = {
        nightLight = {
          enable = true;
          mode = "location";
          temperature = {
            day = 6500;
            night = 2200;
          };
          location = {
            inherit latitude longitude;
          };
        };

        titlebarButtons = {
          left = [
            "close"
            "minimize"
            "maximize"
            "on-all-desktops"
          ];
          right = [
            "help"
            "more-window-actions"
          ];
        };

        borderlessMaximizedWindows = true;

        effects = {
          blur.enable = false;
          desktopSwitching.animation = "slide";
          dimInactive.enable = true;
          shakeCursor.enable = false;
        };

        virtualDesktops = {
          rows = 1;
          names = cfg.virtualDesktopsNames;
        };
      };

      configFile = {
        kwinrc = {
          # Effect-blur.BlurStrength = 3;
          Effect-diminactive.DimFullScreen = false;
          Effect-overview.BorderActivate = 7;
          Effect-overview.BorderActivateAll = 9;
          ElectricBorders.TopRight = "LockScreen";

          Plugins = {
            contrastEnabled = true;
          };

          Windows = {
            CenterSnapZone = 100;
            ElectricBorderCooldown = 400;
            ElectricBorderDelay = 350;
            FocusPolicy = "FocusFollowsMouse";
            NextFocusPrefersMouse = true;
          };
        };
      };
    };
  };
}
