{
  config,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.desktop.plasma.config;
in
{
  options.${namespace}.desktop.plasma.config = {
    enable = mkBoolOpt false "Whether or not to configure plasma config.";
    screenlocker.enable = mkBoolOpt true "Whether or not to enable the screen locker.";
  };

  config = mkIf cfg.enable {
    programs.plasma = {
      enable = true;

      kscreenlocker = {
        appearance = {
          alwaysShowClock = true;
          showMediaControls = true;
          wallpaperPictureOfTheDay.provider = "apod";
        };

        autoLock = cfg.screenlocker.enable;
        lockOnResume = true;
        lockOnStartup = false;
        passwordRequired = true;
        passwordRequiredDelay = 10;
        timeout = 10;
      };

      krunner = {
        activateWhenTypingOnDesktop = true;
        position = "center";
        historyBehavior = "enableAutoComplete";
      };

      configFile = {
        baloofilerc."Basic Settings".Indexing-Enabled = false;

        dolphinrc.VersionControl.enabledPlugins = "Git";

        ## Peripherals

        # Tablet settings
        kcminputrc = {
          "ButtonRebinds.Tablet.Wacom Intuos BT S Pad"."0" = "Key,Ctrl+Z";
          "ButtonRebinds.Tablet.Wacom Intuos Pro S Pad"."0" = "Key,Ctrl+Z";
          "ButtonRebinds.Tablet.Wacom Intuos Pro S Pad"."6" = "Key,Ctrl+Z";
          "Libinput.1386.914.Wacom Intuos Pro S Finger"."NaturalScroll" = true;
          "Libinput.1386.914.Wacom Intuos Pro S Finger"."PointerAccelerationProfile" = 1;
          # Mouse settings
          "Libinput.1133.16511.Logitech G502"."PointerAccelerationProfile" = 1;
          Mouse.X11LibInputXAccelProfileFlat = false;
          Keyboard.NumLock = 0; # enable numlock
        };
      };
    };
  };
}
