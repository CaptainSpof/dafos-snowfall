{
  config,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkOpt mkBoolOpt;
  inherit (config.${namespace}.user) home;
  inherit (config.${namespace}.user.location) latitude longitude;

  cfg = config.${namespace}.desktop.plasma.config;
in
{
  options.${namespace}.desktop.plasma.config = {
    enable = mkBoolOpt false "Whether or not to configure plasma config.";
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
      enable = true;

      fonts = {
        general = {
          family = "Inter";
          pointSize = 10;
        };
        fixedWidth = {
          family = "Departure Mono";
          pointSize = 10;
        };
        small = {
          family = "Inter";
          pointSize = 8;
        };
        toolbar = {
          family = "Inter";
          pointSize = 10;
        };
        menu = {
          family = "Inter";
          pointSize = 10;
        };
        windowTitle = {
          family = "Inter";
          pointSize = 10;
        };
      };

      kscreenlocker = {
        appearance = {
          alwaysShowClock = true;
          showMediaControls = true;
          wallpaperPictureOfTheDay.provider = "apod";
        };

        autoLock = true;
        lockOnResume = true;
        lockOnStartup = false;
        passwordRequired = true;
        passwordRequiredDelay = 10;
        timeout = 10;
      };

      workspace = {
        clickItemTo = "open";
        colorScheme = "Gruvbox";
        cursor.theme = "breeze_cursors";
        lookAndFeel = "org.kde.breezetwilight.desktop";
        soundTheme = "ocean";
        tooltipDelay = 5;
        wallpaperSlideShow = {
          path = "${home}/Pictures/wallpapers/";
          interval = 300;
        };
      };

      krunner = {
        activateWhenTypingOnDesktop = true;
        position = "center";
        historyBehavior = "enableAutoComplete";
      };

      kwin = {
        nightLight = {
          enable = true;
          mode = "location";
          temperature = {
            day = 6500;
            night = 2200;
          };
          location = {
            inherit latitude;
            inherit longitude;
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
          blur.enable = true;
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

        kdeglobals.KDE.widgetStyle = "Lightly";

        kwinrc = {
          Effect-blur.BlurStrength = 3;
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

          "org.kde.kdecoration2" = {
            BorderSize = "Tiny";
            BorderSizeAuto = false;
            library = "org.kde.breeze";
            theme = "Breeze";
          };
        };
      };

      # configFile = {
      #   "kdeglobals"."KDE"."ShowDeleteCommand" = false;
      #   "kdeglobals"."KFileDialog Settings"."Breadcrumb Navigation" = true;
      #   "kdeglobals"."KFileDialog Settings"."Decoration position" = 2;
      #   "kdeglobals"."KFileDialog Settings"."LocationCombo Completionmode" = 5;
      #   "kdeglobals"."KFileDialog Settings"."PathCombo Completionmode" = 5;
      #   "kdeglobals"."KFileDialog Settings"."Show Bookmarks" = false;
      #   "kdeglobals"."KFileDialog Settings"."Show Full Path" = false;
      #   "kdeglobals"."KFileDialog Settings"."Show Inline Previews" = true;
      #   "kdeglobals"."KFileDialog Settings"."Show Preview" = false;
      #   "kdeglobals"."KFileDialog Settings"."Show Speedbar" = true;
      #   "kdeglobals"."KFileDialog Settings"."Show hidden files" = true;
      #   "kdeglobals"."KFileDialog Settings"."Sort by" = "Name";
      #   "kdeglobals"."KFileDialog Settings"."Sort directories first" = true;
      #   "kdeglobals"."KFileDialog Settings"."Sort hidden files last" = false;
      #   "kdeglobals"."KFileDialog Settings"."Sort reversed" = true;
      #   "kdeglobals"."KFileDialog Settings"."Speedbar Width" = 138;
      #   "kdeglobals"."KFileDialog Settings"."View Style" = "DetailTree";
      #   "kdeglobals"."WM"."activeBackground" = "108,78,70";
      #   "kdeglobals"."WM"."activeBlend" = "118,144,40";
      #   "kdeglobals"."WM"."activeForeground" = "217,213,197";
      #   "kdeglobals"."WM"."inactiveBackground" = "90,84,51";
      #   "kdeglobals"."WM"."inactiveBlend" = "143,133,117";
      #   "kdeglobals"."WM"."inactiveForeground" = "158,155,140";

      #   "krunnerrc"."Runners.CharacterRunner"."aliases" = "ar";
      #   "krunnerrc"."Runners.CharacterRunner"."codes" = 002192;
      #   "krunnerrc"."Runners.CharacterRunner"."triggerWord" = "$";
      #   "krunnerrc"."Runners.Dictionary"."triggerWord" = "=";
      #   "krunnerrc"."Runners.Kill Runner"."sorting" = 1;
      #   "krunnerrc"."Runners.Kill Runner"."triggerWord" = "kill";
      #   "krunnerrc"."Runners.Kill Runner"."useTriggerWord" = true;
      #   "krunnerrc"."Runners.krunner_spellcheck"."requireTriggerWord" = true;
      #   "krunnerrc"."Runners.krunner_spellcheck"."trigger" = "~";
      # };
    };
  };
}
