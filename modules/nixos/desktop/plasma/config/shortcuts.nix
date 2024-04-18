{ ... }:

{
  programs.plasma = {
    shortcuts = {
      "services/kitty.desktop"."_launch" = "Ctrl+Alt+T";

      "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" =
        "Meta+Alt+K";

      "emacsclient.desktop"."new-instance" = "Meta+É";

      "kcm_touchpad"."Disable Touchpad" = "Touchpad Off";
      "kcm_touchpad"."Enable Touchpad" = "Touchpad On";
      "kcm_touchpad"."Toggle Touchpad" = "Touchpad Toggle";

      "kded5"."Show System Activity" = "Ctrl+Esc";
      "kded5"."display" = [ "Display" "Meta+P" ];

      "kmix"."decrease_microphone_volume" = "Microphone Volume Down";
      "kmix"."decrease_volume" = "Volume Down";
      "kmix"."increase_microphone_volume" = "Microphone Volume Up";
      "kmix"."increase_volume" = "Volume Up";
      "kmix"."mic_mute" = [ "Microphone Mute" "Meta+Volume Mute" ];
      "kmix"."mute" = "Volume Mute";

      "ksmserver"."Lock Session" = [
        "Meta+Monitor Brightness Up"
        "Meta+Monitor Brightness Down"
        "Screensaver"
      ];
      "ksmserver"."Log Out" = "Ctrl+Alt+Del";

      "kwin"."Activate Window Demanding Attention" = "Meta+Ctrl+A";
      "kwin"."Edit Tiles" = "Meta+Alt+Space";
      "kwin"."Expose" = "Meta+,";
      "kwin"."ExposeAll" = [ "Launch (C)" ];
      "kwin"."ExposeClass" = "Ctrl+F7";
      "kwin"."Window No Border" = [ "Meta+Shift+B" "Meta+Alt+B" ];

      "kwin"."Kill Window" = "Meta+Ctrl+Esc";
      "kwin"."MoveMouseToCenter" = "Meta+F6";
      "kwin"."MoveMouseToFocus" = "Meta+F5";
      "kwin"."Overview" = "Meta+W";

      "kwin"."ShowDesktopGrid" = "Meta+F8";
      "kwin"."Suspend Compositing" = "Alt+Shift+F12";
      "kwin"."Switch Window Down" = "Meta+T";
      "kwin"."Switch Window Left" = "Meta+C";
      "kwin"."Switch Window Right" = "Meta+R";
      "kwin"."Switch Window Up" = "Meta+S";
      "kwin"."Switch to Next Desktop" = "Meta+H";
      "kwin"."Switch to Previous Desktop" = "Meta+G";
      "kwin"."ToggleMouseClick" = "Meta+*";
      "kwin"."Window Close" = [ "Alt+F4" "Meta+Q" ];
      "kwin"."Window Fullscreen" =
        [ "Meta+Ctrl+F" "Meta+Shift+F" "Meta+Shift+Return" "Meta+Alt+Return" ];
      "kwin"."Window Maximize" = [ "Meta+PgUp" "Meta+Return" ];
      "kwin"."Window Minimize" = "Meta+PgDown";
      "kwin"."Window On All Desktops" = [ "Meta+Shift+P" "Meta+Alt+A" ];
      "kwin"."Window One Desktop to the Left" = "Meta+Shift+G";
      "kwin"."Window One Desktop to the Right" = "Meta+Shift+H";
      "kwin"."Window Operations Menu" = "Alt+F3";
      "kwin"."Window Quick Tile Bottom" = "Meta+Down";
      "kwin"."Window Quick Tile Left" = "Meta+Left";
      "kwin"."Window Quick Tile Right" = "Meta+Right";
      "kwin"."Window Quick Tile Top" = "Meta+Up";
      "kwin"."Window Resize" = "Meta+Alt+R";
      "kwin"."Window to Next Screen" =
        [ "Meta+Shift+Right" "Meta+Ctrl+Shift+R" ];
      "kwin"."Window to Previous Screen" =
        [ "Meta+Shift+Left" "Meta+Ctrl+Shift+C" ];
      "kwin"."view_actual_size" = "Meta+0";

      # KZones
      "kwin"."KZones: Cycle layouts" = "Ctrl+Alt+D";
      "kwin"."KZones: Move active window to next zone" = "Ctrl+Alt+Right";
      "kwin"."KZones: Move active window to previous zone" = "Ctrl+Alt+Left";
      "kwin"."KZones: Move active window to zone 1" = "Ctrl+Alt+Num+1";
      "kwin"."KZones: Move active window to zone 2" = "Ctrl+Alt+Num+2";
      "kwin"."KZones: Move active window to zone 3" = "Ctrl+Alt+Num+3";
      "kwin"."KZones: Move active window to zone 4" = "Ctrl+Alt+Num+4";
      "kwin"."KZones: Move active window to zone 5" = "Ctrl+Alt+Num+5";
      "kwin"."KZones: Move active window to zone 6" = "Ctrl+Alt+Num+6";
      "kwin"."KZones: Move active window to zone 7" = "Ctrl+Alt+Num+7";
      "kwin"."KZones: Move active window to zone 8" = "Ctrl+Alt+Num+8";
      "kwin"."KZones: Move active window to zone 9" = "Ctrl+Alt+Num+9";
      "kwin"."KZones: Switch to next window in current zone" = "Ctrl+Alt+Up";
      "kwin"."KZones: Switch to previous window in current zone" =
        "Ctrl+Alt+Down";
      "kwin"."KZones: Toggle OSD" = "Ctrl+Alt+C";

      "mediacontrol"."nextmedia" = "Media Next";
      "mediacontrol"."pausemedia" = "Media Pause";
      "mediacontrol"."playpausemedia" = "Media Play";
      "mediacontrol"."previousmedia" = "Media Previous";
      "mediacontrol"."stopmedia" = "Media Stop";

      "org.kde.dolphin.desktop"."_launch" = "Meta+E";
      "org.kde.krunner.desktop"."RunClipboard" = "Alt+Shift+F2";
      "org.kde.krunner.desktop"."_launch" = [ "Meta+Space" "Alt+F2" "Search" ];
      "org.kde.plasma.emojier.desktop"."_launch" = "Meta+.";

      "org.kde.spectacle.desktop"."ActiveWindowScreenShot" = "Meta+Print";
      "org.kde.spectacle.desktop"."FullScreenScreenShot" = "Shift+Print";
      "org.kde.spectacle.desktop"."RectangularRegionScreenShot" =
        "Meta+Shift+Print";
      "org.kde.spectacle.desktop"."WindowUnderCursorScreenShot" =
        "Meta+Ctrl+Print";
      "org.kde.spectacle.desktop"."_launch" = "Print";

      "plasmashell"."clipboard_action" = "Meta+Ctrl+X";
      "plasmashell"."cycle-panels" = "Meta+Alt+P";
      "plasmashell"."next activity" = "Meta+Tab";
      "plasmashell"."previous activity" = "Meta+Shift+Tab";
      "plasmashell"."show dashboard" = [ "Ctrl+F12" "Meta+D" ];
      "plasmashell"."show-on-mouse-pos" = "Meta+V";

      # Disabled/Unmapped Shortcuts
      "kwin"."Switch One Desktop Down" = [ ];
      "kwin"."Switch One Desktop Up" = [ ];
      "kwin"."Switch One Desktop to the Left" = [ ];
      "kwin"."Switch One Desktop to the Right" = [ ];
      "kwin"."Switch to Desktop 5" = [ ];
      "kwin"."Switch to Desktop 6" = [ ];
      "kwin"."Switch to Desktop 7" = [ ];
      "kwin"."Switch to Desktop 8" = [ ];
      "kwin"."Switch to Desktop 9" = [ ];
      "kwin"."Switch to Next Screen" = [ ];
      "kwin"."Switch to Previous Screen" = [ ];
      "kwin"."Switch to Screen Above" = [ ];
      "kwin"."Switch to Screen Below" = [ ];
      "kwin"."Switch to Screen to the Left" = [ ];
      "kwin"."Switch to Screen to the Right" = [ ];
      "kwin"."Window Grow Horizontal" = [ ];
      "kwin"."Window Grow Vertical" = [ ];
      "kwin"."Window Lower" = [ ];
      "kwin"."Window Maximize Horizontal" = [ ];
      "kwin"."Window Maximize Vertical" = [ ];
      "kwin"."Window Move" = [ ];
      "kwin"."Window Move Center" = [ ];
      "kwin"."Window Pack Down" = [ ];
      "kwin"."Window Pack Left" = [ ];
      "kwin"."Window Pack Right" = [ ];
      "kwin"."Window Pack Up" = [ ];
      "kwin"."Window Quick Tile Bottom Left" = [ ];
      "kwin"."Window Quick Tile Bottom Right" = [ ];
      "kwin"."Window Quick Tile Top Left" = [ ];
      "kwin"."Window Quick Tile Top Right" = [ ];
      "kwin"."Window Raise" = [ ];
      "kwin"."Window Shrink Horizontal" = [ ];
      "kwin"."Window Shrink Vertical" = [ ];
      "kwin"."Window to Next Desktop" = [ ];
      "kwin"."Window to Previous Desktop" = [ ];
      "kwin"."view_zoom_in" = [ ];
      "kwin"."view_zoom_out" = [ ];
      "mediacontrol"."playmedia" = [ ];
      "org.kde.konsole.desktop"."_launch" = [ ];
      "org.kde.spectacle.desktop"."CurrentMonitorScreenShot" = [ ];
      "org.kde.spectacle.desktop"."OpenWithoutScreenshot" = [ ];
      "plasmashell"."activate task manager entry 1" = [ ];
      "plasmashell"."activate task manager entry 2" = [ ];
      "plasmashell"."activate task manager entry 3" = [ ];
      "plasmashell"."activate task manager entry 4" = [ ];
      "plasmashell"."activate task manager entry 5" = [ ];
      "plasmashell"."activate task manager entry 6" = [ ];
      "plasmashell"."activate task manager entry 7" = [ ];
      "plasmashell"."activate task manager entry 8" = [ ];
      "plasmashell"."activate task manager entry 9" = [ ];
      "plasmashell"."activate task manager entry 10" = [ ];
      "kaccess"."Toggle Screen Reader On and Off" = [ ];
      "kwin"."ExposeClassCurrentDesktop" = [ ];
      # Polonium
      "kwin"."PoloniumCycleLayouts" = [ ];
      "kwin"."PoloniumFocusAbove" = [ ];
      "kwin"."PoloniumFocusBelow" = [ ];
      "kwin"."PoloniumFocusLeft" = [ ];
      "kwin"."PoloniumFocusRight" = [ ];
      "kwin"."PoloniumRebuildLayout" = [ ];
      "kwin"."PoloniumResizeTileDown" = [ ];
      "kwin"."PoloniumResizeTileLeft" = [ ];
      "kwin"."PoloniumResizeTileRight" = [ ];
      "kwin"."PoloniumResizeTileUp" = [ ];
      "kwin"."PoloniumRetileWindow" = [ ];
      "kwin"."PoloniumShowSettings" = [ ];
      "kwin"."PoloniumSwapAbove" = [ ];
      "kwin"."PoloniumSwapBelow" = [ ];
      "kwin"."PoloniumSwapLeft" = [ ];
      "kwin"."PoloniumSwapRight" = [ ];
      "kwin"."PoloniumEngineBTree" = [ ];
      "kwin"."PoloniumEngineHalf" = [ ];
      "kwin"."PoloniumEngineKWin" = [ ];
      "kwin"."PoloniumEngineMonocle" = [ ];
      "kwin"."PoloniumEngineThreeColumn" = [ ];
      "kwin"."PoloniumInsertAbove" = [ ];
      "kwin"."PoloniumInsertBelow" = [ ];
      "kwin"."PoloniumInsertLeft" = [ ];
      "kwin"."PoloniumInsertRight" = [ ];
      "kwin"."Setup Window Shortcut" = [ ];
      "kwin"."Window One Desktop Down" = [ ];
      "kwin"."Window One Desktop Up" = [ ];
      "kwin"."Switch to Desktop 1" = [ ];
      "kwin"."Switch to Desktop 2" = [ ];
      "kwin"."Switch to Desktop 3" = [ ];
      "kwin"."Switch to Desktop 4" = [ ];
      "kwin"."Show Desktop" = [ ];
    };
  };
}
