{ pkgs, inputs, ... }:

let
  inherit (inputs) plasma-manager;
in
{
  dafos.home.extraOptions = {
    imports = [
      plasma-manager.homeManagerModules.plasma-manager
      ./shortcuts.nix
      ./panels.nix
    ];

    programs.plasma = {
      enable = true;

      workspace = {
        clickItemTo = "open";
        # tooltipDelay = 5;
        # cursorTheme = "breeze_cursors";
        colorScheme = "gruvbox";
        lookAndFeel = "org.kde.breezetwilight.desktop";
      };

      kwin = {
        effects.shakeCursor.enable = true;
        virtualDesktops = {
          animation = "slide";
          rows = 1;
          names = ["Mail" "Video" "Stuff" "Other" "Yes"];
        };
      };


      configFile = {

        baloofilerc."Basic Settings".Indexing-Enabled = false;

        dolphinrc.VersionControl.enabledPlugins = "Git";

        ## Peripherals

        # Tablet settings
        kcminputrc."ButtonRebinds.Tablet.Wacom Intuos BT S Pad"."0" = "Key,Ctrl+Z";
        kcminputrc."ButtonRebinds.Tablet.Wacom Intuos Pro S Pad"."0" = "Key,Ctrl+Z";
        kcminputrc."ButtonRebinds.Tablet.Wacom Intuos Pro S Pad"."6" = "Key,Ctrl+Z";
        kcminputrc."Libinput.1386.914.Wacom Intuos Pro S Finger"."NaturalScroll" = true;
        kcminputrc."Libinput.1386.914.Wacom Intuos Pro S Finger"."PointerAccelerationProfile" = 1;

        # Mouse settings
        kcminputrc."Libinput.1133.16511.Logitech G502"."PointerAccelerationProfile" = 1;
        kcminputrc.Mouse."X11LibInputXAccelProfileFlat" = false;

        "kdeglobals"."KDE"."widgetStyle" = "Lightly";
        kwinrc = {
          "Windows"."BorderlessMaximizedWindows" = true;
        };

        krunnerrc = {
          General.FreeFloating.value = true;

          Plugins.appstreamEnabled = false;
        };

        Plugins = {
          cubeEnabled.value = true;
          dimscreenEnabled.value = true;
          shakecursorEnabled.value = true;
          sheetEnabled.value = true;
          wobblywindowsEnabled.value = true;
        };
      };

      # configFile = {
      #   "dolphinrc"."CreateDialog"."LastMimeType" = "application/x-compressed-tar";
      #   "dolphinrc"."DetailsMode"."SidePadding" = 0;
      #   "dolphinrc"."General"."ShowSpaceInfo" = false;
      #   "dolphinrc"."General"."ShowToolTips" = true;
      #   "dolphinrc"."KFileDialog Settings"."Places Icons Auto-resize" = false;
      #   "dolphinrc"."KFileDialog Settings"."Places Icons Static Size" = 22;
      #   "dolphinrc"."KFileDialog Settings"."detailViewIconSize" = 16;
      #   "dolphinrc"."MainWindow.Toolbar mainToolBar"."ToolButtonStyle" = "IconOnly";
      #   "dolphinrc"."PreviewSettings"."Plugins" = "audiothumbnail,blenderthumbnail,comicbookthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,directorythumbnail,fontthumbnail,imagethumbnail,jpegthumbnail,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,mobithumbnail,opendocumentthumbnail,gsthumbnail,rawthumbnail,svgthumbnail,ffmpegthumbs";
      #   "dolphinrc"."Toolbar mainToolBar"."ToolButtonStyle" = "IconOnly";
      #   "dolphinrc"."VersionControl"."enabledPlugins" = "Git";

      #   "kdeglobals"."General"."AllowKDEAppsToRememberWindowPositions" = true;
      #   # TODO: parameterize
      #   "kdeglobals"."General"."BrowserApplication" = "firefox.desktop";
      #   "kdeglobals"."General"."TerminalApplication" = "alacritty";
      #   "kdeglobals"."General"."TerminalService" = "Alacritty.desktop";
      #   "kdeglobals"."General"."XftHintStyle" = "hintmedium";
      #   "kdeglobals"."General"."XftSubPixel" = "rgb";
      #   "kdeglobals"."KDE"."ShowDeleteCommand" = false;
      #   "kdeglobals"."KDE"."SingleClick" = true;
      #   # "kdeglobals"."KDE"."widgetStyle" = "Lightly";
      #   "kdeglobals"."KFileDialog Settings"."Allow Expansion" = false;
      #   "kdeglobals"."KFileDialog Settings"."Automatically select filename extension" = true;
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
      #   # TODO: parameterize
      #   "kglobalshortcutsrc"."Alacritty.desktop"."_k_friendly_name" = "Alacritty";
      #   "kglobalshortcutsrc"."KDE Keyboard Layout Switcher"."_k_friendly_name" = "Keyboard Layout Switcher";
      #   "kglobalshortcutsrc"."emacsclient.desktop"."_k_friendly_name" = "Emacs (Client)";
      #   "kglobalshortcutsrc"."kaccess"."_k_friendly_name" = "Accessibility";
      #   "kglobalshortcutsrc"."kcm_touchpad"."_k_friendly_name" = "Touchpad";
      #   "kglobalshortcutsrc"."kded5"."_k_friendly_name" = "KDE Daemon";
      #   "kglobalshortcutsrc"."khotkeys"."_k_friendly_name" = "Custom Shortcuts Service";
      #   "kglobalshortcutsrc"."kmix"."_k_friendly_name" = "Audio Volume";
      #   "kglobalshortcutsrc"."ksmserver"."_k_friendly_name" = "Session Management";
      #   "kglobalshortcutsrc"."kwin"."_k_friendly_name" = "KWin";
      #   "kglobalshortcutsrc"."mediacontrol"."_k_friendly_name" = "Media Controller";
      #   "kglobalshortcutsrc"."org.kde.dolphin.desktop"."_k_friendly_name" = "Dolphin";
      #   "kglobalshortcutsrc"."org.kde.kcalc.desktop"."_k_friendly_name" = "KCalc";
      #   "kglobalshortcutsrc"."org.kde.konsole.desktop"."_k_friendly_name" = "Konsole";
      #   "kglobalshortcutsrc"."org.kde.krunner.desktop"."_k_friendly_name" = "KRunner";
      #   "kglobalshortcutsrc"."org.kde.plasma.emojier.desktop"."_k_friendly_name" = "Emoji Selector";
      #   "kglobalshortcutsrc"."org.kde.spectacle.desktop"."_k_friendly_name" = "Spectacle";
      #   "kglobalshortcutsrc"."org_kde_powerdevil"."_k_friendly_name" = "Power Management";
      #   "kglobalshortcutsrc"."plasmashell"."_k_friendly_name" = "Plasma";
      #   "kglobalshortcutsrc"."systemsettings.desktop"."_k_friendly_name" = "System Settings";

      #   "klaunchrc"."BusyCursorSettings"."Timeout" = 3;
      #   "klaunchrc"."TaskbarButtonSettings"."Timeout" = 3;

      #   "klipperrc"."General"."IgnoreImages" = false;
      #   "klipperrc"."General"."MaxClipItems" = 30;

      #   "krunnerrc"."Plugins"."appstreamEnabled" = false;
      #   "krunnerrc"."Runners.CharacterRunner"."aliases" = "ar";
      #   "krunnerrc"."Runners.CharacterRunner"."codes" = 002192;
      #   "krunnerrc"."Runners.CharacterRunner"."triggerWord" = "$";
      #   "krunnerrc"."Runners.Dictionary"."triggerWord" = "=";
      #   "krunnerrc"."Runners.Kill Runner"."sorting" = 1;
      #   "krunnerrc"."Runners.Kill Runner"."triggerWord" = "kill";
      #   "krunnerrc"."Runners.Kill Runner"."useTriggerWord" = true;
      #   "krunnerrc"."Runners.krunner_spellcheck"."requireTriggerWord" = true;
      #   "krunnerrc"."Runners.krunner_spellcheck"."trigger" = "~";

      #   "kwalletrc"."Wallet"."First Use" = false;

      #   "kwinrc"."Windows"."BorderlessMaximizedWindows" = true;
      #   "kwinrc"."Compositing"."LatencyPolicy" = "Medium";
      #   "kwinrc"."Effect-kwin4_effect_glitch"."Color" = "108,78,70";
      #   "kwinrc"."Effect-kwin4_effect_glitch"."Duration" = 850;
      #   "kwinrc"."Effect-kwin4_effect_glitch"."Scale" = 2;
      #   "kwinrc"."Effect-kwin4_effect_glitch"."Speed" = 0.8;
      #   "kwinrc"."Effect-kwin4_effect_glitch"."Strength" = 10;
      #   "kwinrc"."Effect-overview"."BorderActivate" = 7;
      #   "kwinrc"."Effect-windowview"."BorderActivateAll" = 9;
      #   "kwinrc"."ElectricBorders"."TopRight" = "LockScreen";
      #   "kwinrc"."ModifierOnlyShortcuts"."Meta" = "org.kde.kglobalaccel,/component/kwin,org.kde.kglobalaccel.Component,invokeShortcut,Overview";
      #   "kwinrc"."MouseBindings"."CommandAllWheel" = "Previous/Next Desktop";
      #   "kwinrc"."NightColor"."Active" = true;
      #   "kwinrc"."NightColor"."LatitudeAuto" = 48.8909;
      #   "kwinrc"."NightColor"."LongitudeAuto" = 2.2093;
      #   "kwinrc"."NightColor"."NightTemperature" = 3800;
      #   "kwinrc"."Plugins"."bismuthEnabled" = true;
      #   "kwinrc"."Plugins"."blurEnabled" = true;
      #   "kwinrc"."Plugins"."contrastEnabled" = true;
      #   "kwinrc"."Plugins"."diminactiveEnabled" = true;
      #   "kwinrc"."Plugins"."kwin4_effect_dimscreenEnabled" = true;
      #   "kwinrc"."Plugins"."kwin4_effect_glitchEnabled" = true;
      #   "kwinrc"."Plugins"."kwin4_effect_scaleEnabled" = false;
      #   "kwinrc"."Plugins"."kwin4_effect_translucencyEnabled" = true;
      #   "kwinrc"."Plugins"."kzonesEnabled" = false;
      #   "kwinrc"."Script-kzones"."invertedMode" = true;
      #   "kwinrc"."Script-kzones"."modifierKey" = 0;
      #   "kwinrc"."Tiling"."padding" = 10;
      #   "kwinrc"."TouchEdges"."Bottom" = "ApplicationLauncher";
      #   "kwinrc"."Wayland"."InputMethod[$e]" = "${pkgs.maliit-keyboard}/share/applications/com.github.maliit.keyboard.desktop";
      #   "kwinrc"."Wayland"."InputMethod\x5b$e\x5d" = "${pkgs.maliit-keyboard}/share/applications/com.github.maliit.keyboard.desktop";
      #   "kwinrc"."Wayland"."VirtualKeyboardEnabled" = false;
      #   "kwinrc"."Windows"."CenterSnapZone" = 100;
      #   "kwinrc"."Windows"."ElectricBorderCooldown" = 400;
      #   "kwinrc"."Windows"."ElectricBorderDelay" = 350;
      #   "kwinrc"."Windows"."FocusPolicy" = "FocusFollowsMouse";
      #   "kwinrc"."Windows"."NextFocusPrefersMouse" = true;
      #   "kwinrc"."Xwayland"."Scale" = 2;
      #   "kwinrc"."org\\.kde\\.kdecoration2"."BorderSize" = "Tiny";
      #   "kwinrc"."org\\.kde\\.kdecoration2"."BorderSizeAuto" = false;
      #   "kwinrc"."org\\.kde\\.kdecoration2"."ButtonsOnLeft" = "XAI";
      #   "kwinrc"."org\\.kde\\.kdecoration2"."ButtonsOnRight" = "NHMS";
      #   "kwinrc"."org\\.kde\\.kdecoration2"."ShowToolTips" = false;
      #   "kxkbrc"."Layout"."DisplayNames" = "bé,";
      #   "kxkbrc"."Layout"."LayoutList" = "fr,fr";
      #   "kxkbrc"."Layout"."Use" = true;
      #   "kxkbrc"."Layout"."VariantList" = "bepo,us";
      #   "plasmanotifyrc"."Notifications"."PopupPosition" = "BottomRight";
      #   # "plasmarc"."Theme"."name" = "gruvbox";
      #   "systemsettingsrc"."KFileDialog Settings"."detailViewIconSize" = 16;
      #   "systemsettingsrc"."Open-with settings"."CompletionMode" = 1;
      # };
    };
  };
}
