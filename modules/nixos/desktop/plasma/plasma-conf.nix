{inputs, ... }:

let
  inherit (inputs) plasma-manager;
in
{

  dafos.home.extraOptions = {

    imports = [ plasma-manager.homeManagerModules.plasma-manager ];

    programs.plasma = {
      enable = true;

      # Some high-level settings:
      workspace.clickItemTo = "select";

      # Some mid-level settings:
      shortcuts = {
        "Alacritty.desktop"."New" = "Meta+Return";
        "alacrittydropdown.sh.desktop"."_launch" = "Meta+D";

        ksmserver."Lock Session" = [ "Screensaver" "Meta+Ctrl+Alt+L" ];

        kwin = {
          "Switch Window Down" = "Meta+T";
          "Switch Window Left" = "Meta+C";
          "Switch Window Right" = "Meta+R";
          "Switch Window Up" = "Meta+S";
          "Switch to Next Desktop" = "Meta+H";
          "Switch to Previous Desktop" = "Meta+G";
          "Window One Desktop to the Left" = "Meta+Shift+G";
          "Window One Desktop to the Right" = "Meta+Shift+H";
          "Window On All Desktops" = "Meta+Alt+A";
          "Window Close" = [ "Alt+F4" "Meta+Q"];
          "Window to Next Screen" = ["Meta+Shift+Right" "Meta+Ctrl+Shift+R"];
          "Window to Previous Screen" = ["Meta+Shift+Left" "Meta+Ctrl+Shift+C"];
          "Window Fullscreen" = [ "Meta+Ctrl+F" "Meta+Shift+F" ];
          "Edit Tiles" = "Meta+Alt+Space";

          "PoloniumCycleLayouts" = "Meta+/";
          "PoloniumFocusAbove" = "Meta+S";
          "PoloniumFocusBelow" = "Meta+T";
          "PoloniumFocusLeft" = "Meta+C";
          "PoloniumFocusRight" = "Meta+R";
          "PoloniumInsertAbove" = "";
          "PoloniumInsertBelow" = "";
          "PoloniumInsertLeft" = [ ];
          "PoloniumInsertRight" = "";
          "PoloniumRebuildLayout" = "Meta+Ctrl+Space";
          "PoloniumResizeTileDown" = "Meta+Ctrl+T";
          "PoloniumResizeTileLeft" = "Meta+Ctrl+C";
          "PoloniumResizeTileRight" = "Meta+Ctrl+R";
          "PoloniumResizeTileUp" = "Meta+Ctrl+S";
          "PoloniumRetileWindow" = "Meta+F";
          "PoloniumSwapAbove" = "Meta+Shift+S";
          "PoloniumSwapBelow" = "Meta+Shift+T";
          "PoloniumSwapLeft" = "Meta+Shift+C";
          "PoloniumSwapRight" = "Meta+Shift+R";

        };

        "org.kde.krunner.desktop"."_launch" = ["Meta+Space" "Alt+F2" "Search"];
      };

      # A low-level setting:
      configFile = {
        "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;

        "dolphinrc"."General"."ShowSpaceInfo" = false; # bottom right disk space indicator looks weird

        "kdeglobals"."KDE"."widgetStyle" = "Lightly";
        "kdeglobals"."KDE"."SingleClick" = true;

        "kded5rc"."Module-bluedevil"."autoload" = true;

        "kwinrc"."Desktops"."Number" = 4;
        "kwinrc"."Desktops"."Rows" = 1;

        "kwinrc"."Effect-overview"."BorderActivate" = 7;
        "kwinrc"."Effect-windowview"."BorderActivateAll" = 9;
        "kwinrc"."TabBox"."TouchBorderActivate" = 6;
        "kwinrc"."TouchEdges"."Bottom" = "ApplicationLauncher";

        # Use Meta key to invoke Overview, à la Gnome
        "kwinrc"."ModifierOnlyShortcuts"."Meta" = "org.kde.kglobalaccel,/component/kwin,org.kde.kglobalaccel.Component,invokeShortcut,Overview";

        "kwinrc"."NightColor"."Active" = true;

        "kwinrc"."Plugins"."poloniumEnabled" = true;
        "kwinrc"."Script-polonium"."MaximizeSingle" = true;

        "kwinrc"."Plugins"."blurEnabled" = true;
        "kwinrc"."Plugins"."diminactiveEnabled" = true;

        "kwinrc"."MouseBindings"."CommandAllWheel" = "Previous/Next Desktop";

        "kwinrc"."Windows"."ElectricBorderCooldown" = 400;
        "kwinrc"."Windows"."ElectricBorderDelay" = 350;
        "kwinrc"."Windows"."FocusPolicy" = "FocusFollowsMouse";
        "kwinrc"."Windows"."NextFocusPrefersMouse" = true;

        "kwinrc"."org.kde.kdecoration2"."ButtonsOnRight" = "NHIAX";
        # TODO: use ${pkgs.maliit}
        "kwinrc"."Wayland"."InputMethod[$e]" = "/run/current-system/sw/share/applications/com.github.maliit.keyboard.desktop";
        "kwinrc"."Wayland"."VirtualKeyboardEnabled" = true;

        "kcminputrc"."Libinput.1386.914.Wacom Intuos Pro S Finger"."NaturalScroll" = true;
        "kcminputrc"."Libinput.1739.52804.MSFT0001:00 06CB:CE44 Touchpad"."ClickMethod" = 2;
        "kcminputrc"."Libinput.1739.52804.MSFT0001:00 06CB:CE44 Touchpad"."NaturalScroll" = true;
        "kcminputrc"."Libinput.1739.52804.MSFT0001:00 06CB:CE44 Touchpad"."TapToClick" = true;

        "ksmserverrc"."General"."loginMode" = "emptySession";
        "ksmserverrc"."General"."shutdownType" = 2; # Preselect "Shutdown"

        "krunnerrc"."General"."FreeFloating" = true;
        "krunnerrc"."Plugins"."appstreamEnabled" = false;
        "krunnerrc"."Runners.Dictionary"."triggerWord" = "=";
        "krunnerrc"."Runners.Kill Runner"."sorting" = 1;
        "krunnerrc"."Runners.Kill Runner"."triggerWord" = "kill";
        "krunnerrc"."Runners.Kill Runner"."useTriggerWord" = true;
        "krunnerrc"."Runners.krunner_spellcheck"."requireTriggerWord" = true;
        "krunnerrc"."Runners.krunner_spellcheck"."trigger" = "~";

        "kxkbrc"."Layout"."DisplayNames" = "bé,";
        "kxkbrc"."Layout"."LayoutList" = "fr,fr";
        "kxkbrc"."Layout"."Use" = true;
        "kxkbrc"."Layout"."VariantList" = "bepo,us";

        # Locale
        # REVIEW: maybe setting it up through nix options is sufficient
        "plasma-localerc"."Formats"."LANG" = "en_US.UTF-8";
        "plasma-localerc"."Formats"."LC_ADDRESS" = "fr_FR.UTF-8";
        "plasma-localerc"."Formats"."LC_MEASUREMENT" = "fr_FR.UTF-8";
        "plasma-localerc"."Formats"."LC_MONETARY" = "fr_FR.UTF-8";
        "plasma-localerc"."Formats"."LC_NAME" = "fr_FR.UTF-8";
        "plasma-localerc"."Formats"."LC_PAGE" = "fr_FR.UTF-8";
        "plasma-localerc"."Formats"."LC_TELEPHONE" = "fr_FR.UTF-8";
        "plasma-localerc"."Formats"."LC_TIME" = "fr_FR.UTF-8";

        "plasmarc"."Theme"."name" = "gruvbox";
      };
    };
  };
}
