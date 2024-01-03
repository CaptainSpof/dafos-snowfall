{ pkgs, inputs, ... }:

let
  inherit (inputs) plasma-manager;
in
{
  dafos.home.extraOptions = {
    imports = [
      plasma-manager.homeManagerModules.plasma-manager
      ./shortcuts.nix
      ./desktop-applets.nix
    ];

    programs.plasma = {
      enable = true;

      workspace = {
        clickItemTo = "open";
        tooltipDelay = 5;
        theme = "gruvbox";
        colorScheme = "BreezeDark";
      };

      configFile = {
        "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
        "baloofilerc"."General"."dbVersion" = 2;
        "baloofilerc"."General"."exclude filters" = "*~,*.part,*.o,*.la,*.lo,*.loT,*.moc,moc_*.cpp,qrc_*.cpp,ui_*.h,cmake_install.cmake,CMakeCache.txt,CTestTestfile.cmake,libtool,config.status,confdefs.h,autom4te,conftest,confstat,Makefile.am,*.gcode,.ninja_deps,.ninja_log,build.ninja,*.csproj,*.m4,*.rej,*.gmo,*.pc,*.omf,*.aux,*.tmp,*.po,*.vm*,*.nvram,*.rcore,*.swp,*.swap,lzo,litmain.sh,*.orig,.histfile.*,.xsession-errors*,*.map,*.so,*.a,*.db,*.qrc,*.ini,*.init,*.img,*.vdi,*.vbox*,vbox.log,*.qcow2,*.vmdk,*.vhd,*.vhdx,*.sql,*.sql.gz,*.ytdl,*.class,*.pyc,*.pyo,*.elc,*.qmlc,*.jsc,*.fastq,*.fq,*.gb,*.fasta,*.fna,*.gbff,*.faa,po,CVS,.svn,.git,_darcs,.bzr,.hg,CMakeFiles,CMakeTmp,CMakeTmpQmake,.moc,.obj,.pch,.uic,.npm,.yarn,.yarn-cache,__pycache__,node_modules,node_packages,nbproject,core-dumps,lost+found";
        "baloofilerc"."General"."exclude filters version" = 8;

        "dolphinrc"."CreateDialog"."LastMimeType" = "application/x-compressed-tar";
        "dolphinrc"."DetailsMode"."SidePadding" = 0;
        "dolphinrc"."General"."ShowSpaceInfo" = false;
        "dolphinrc"."General"."ShowToolTips" = true;
        "dolphinrc"."KFileDialog Settings"."Places Icons Auto-resize" = false;
        "dolphinrc"."KFileDialog Settings"."Places Icons Static Size" = 22;
        "dolphinrc"."KFileDialog Settings"."detailViewIconSize" = 16;
        "dolphinrc"."MainWindow.Toolbar mainToolBar"."ToolButtonStyle" = "IconOnly";
        "dolphinrc"."PreviewSettings"."Plugins" = "audiothumbnail,blenderthumbnail,comicbookthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,directorythumbnail,fontthumbnail,imagethumbnail,jpegthumbnail,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,mobithumbnail,opendocumentthumbnail,gsthumbnail,rawthumbnail,svgthumbnail,ffmpegthumbs";
        "dolphinrc"."Toolbar mainToolBar"."ToolButtonStyle" = "IconOnly";
        "dolphinrc"."VersionControl"."enabledPlugins" = "Git";

        # Peripherals
        "kcminputrc"."ButtonRebinds.Tablet.Wacom Intuos BT S Pad"."0" = "Key,Ctrl+Z";
        "kcminputrc"."ButtonRebinds.Tablet.Wacom Intuos Pro S Pad"."0" = "Key,Ctrl+Z";
        "kcminputrc"."ButtonRebinds.Tablet.Wacom Intuos Pro S Pad"."6" = "Key,Ctrl+Z";
        "kcminputrc"."Libinput.1133.16511.Logitech G502"."PointerAccelerationProfile" = 1;
        "kcminputrc"."Libinput.1386.21203.Wacom HID 52D3 Pen"."Orientation" = 0;
        "kcminputrc"."Libinput.1386.914.Wacom Intuos Pro S Finger"."NaturalScroll" = true;
        "kcminputrc"."Libinput.1386.914.Wacom Intuos Pro S Finger"."PointerAccelerationProfile" = 1;
        "kcminputrc"."Mouse"."X11LibInputXAccelProfileFlat" = false;
        "kcminputrc"."Mouse"."cursorTheme" = "breeze_cursors";
        "kcminputrc"."Tmp"."update_info" = "delete_cursor_old_default_size.upd:DeleteCursorOldDefaultSize";

        "kded5rc"."Module-appmenu"."autoload" = true;
        "kded5rc"."Module-baloosearchmodule"."autoload" = true;
        "kded5rc"."Module-bluedevil"."autoload" = true;
        "kded5rc"."Module-browserintegrationreminder"."autoload" = false;
        "kded5rc"."Module-colorcorrectlocationupdater"."autoload" = true;
        "kded5rc"."Module-device_automounter"."autoload" = false;
        "kded5rc"."Module-freespacenotifier"."autoload" = true;
        "kded5rc"."Module-gtkconfig"."autoload" = true;
        "kded5rc"."Module-kded_touchpad"."autoload" = true;
        "kded5rc"."Module-keyboard"."autoload" = true;
        "kded5rc"."Module-khotkeys"."autoload" = true;
        "kded5rc"."Module-kscreen"."autoload" = true;
        "kded5rc"."Module-ksysguard"."autoload" = true;
        "kded5rc"."Module-ktimezoned"."autoload" = true;
        "kded5rc"."Module-networkmanagement"."autoload" = true;
        "kded5rc"."Module-networkstatus"."autoload" = true;
        "kded5rc"."Module-plasma_accentcolor_service"."autoload" = true;
        "kded5rc"."Module-printmanager"."autoload" = true;
        "kded5rc"."Module-proxyscout"."autoload" = true;
        "kded5rc"."Module-remotenotifier"."autoload" = true;
        "kded5rc"."Module-smbwatcher"."autoload" = true;
        "kded5rc"."Module-statusnotifierwatcher"."autoload" = true;
        "kded5rc"."PlasmaBrowserIntegration"."shownCount" = 4;

        "kdeglobals"."General"."AllowKDEAppsToRememberWindowPositions" = true;
        # TODO: parameterize
        "kdeglobals"."General"."BrowserApplication" = "firefox.desktop";
        "kdeglobals"."General"."TerminalApplication" = "alacritty";
        "kdeglobals"."General"."TerminalService" = "Alacritty.desktop";
        "kdeglobals"."General"."XftHintStyle" = "hintmedium";
        "kdeglobals"."General"."XftSubPixel" = "rgb";
        "kdeglobals"."KDE"."ShowDeleteCommand" = false;
        "kdeglobals"."KDE"."SingleClick" = true;
        # "kdeglobals"."KDE"."widgetStyle" = "Lightly";
        "kdeglobals"."KFileDialog Settings"."Allow Expansion" = false;
        "kdeglobals"."KFileDialog Settings"."Automatically select filename extension" = true;
        "kdeglobals"."KFileDialog Settings"."Breadcrumb Navigation" = true;
        "kdeglobals"."KFileDialog Settings"."Decoration position" = 2;
        "kdeglobals"."KFileDialog Settings"."LocationCombo Completionmode" = 5;
        "kdeglobals"."KFileDialog Settings"."PathCombo Completionmode" = 5;
        "kdeglobals"."KFileDialog Settings"."Show Bookmarks" = false;
        "kdeglobals"."KFileDialog Settings"."Show Full Path" = false;
        "kdeglobals"."KFileDialog Settings"."Show Inline Previews" = true;
        "kdeglobals"."KFileDialog Settings"."Show Preview" = false;
        "kdeglobals"."KFileDialog Settings"."Show Speedbar" = true;
        "kdeglobals"."KFileDialog Settings"."Show hidden files" = true;
        "kdeglobals"."KFileDialog Settings"."Sort by" = "Name";
        "kdeglobals"."KFileDialog Settings"."Sort directories first" = true;
        "kdeglobals"."KFileDialog Settings"."Sort hidden files last" = false;
        "kdeglobals"."KFileDialog Settings"."Sort reversed" = true;
        "kdeglobals"."KFileDialog Settings"."Speedbar Width" = 138;
        "kdeglobals"."KFileDialog Settings"."View Style" = "DetailTree";
        "kdeglobals"."WM"."activeBackground" = "108,78,70";
        "kdeglobals"."WM"."activeBlend" = "118,144,40";
        "kdeglobals"."WM"."activeForeground" = "217,213,197";
        "kdeglobals"."WM"."inactiveBackground" = "90,84,51";
        "kdeglobals"."WM"."inactiveBlend" = "143,133,117";
        "kdeglobals"."WM"."inactiveForeground" = "158,155,140";
        # TODO: parameterize
        "kglobalshortcutsrc"."Alacritty.desktop"."_k_friendly_name" = "Alacritty";
        "kglobalshortcutsrc"."KDE Keyboard Layout Switcher"."_k_friendly_name" = "Keyboard Layout Switcher";
        "kglobalshortcutsrc"."emacsclient.desktop"."_k_friendly_name" = "Emacs (Client)";
        "kglobalshortcutsrc"."kaccess"."_k_friendly_name" = "Accessibility";
        "kglobalshortcutsrc"."kcm_touchpad"."_k_friendly_name" = "Touchpad";
        "kglobalshortcutsrc"."kded5"."_k_friendly_name" = "KDE Daemon";
        "kglobalshortcutsrc"."khotkeys"."_k_friendly_name" = "Custom Shortcuts Service";
        "kglobalshortcutsrc"."kmix"."_k_friendly_name" = "Audio Volume";
        "kglobalshortcutsrc"."ksmserver"."_k_friendly_name" = "Session Management";
        "kglobalshortcutsrc"."kwin"."_k_friendly_name" = "KWin";
        "kglobalshortcutsrc"."mediacontrol"."_k_friendly_name" = "Media Controller";
        "kglobalshortcutsrc"."org.kde.dolphin.desktop"."_k_friendly_name" = "Dolphin";
        "kglobalshortcutsrc"."org.kde.kcalc.desktop"."_k_friendly_name" = "KCalc";
        "kglobalshortcutsrc"."org.kde.konsole.desktop"."_k_friendly_name" = "Konsole";
        "kglobalshortcutsrc"."org.kde.krunner.desktop"."_k_friendly_name" = "KRunner";
        "kglobalshortcutsrc"."org.kde.plasma.emojier.desktop"."_k_friendly_name" = "Emoji Selector";
        "kglobalshortcutsrc"."org.kde.spectacle.desktop"."_k_friendly_name" = "Spectacle";
        "kglobalshortcutsrc"."org_kde_powerdevil"."_k_friendly_name" = "Power Management";
        "kglobalshortcutsrc"."plasmashell"."_k_friendly_name" = "Plasma";
        "kglobalshortcutsrc"."systemsettings.desktop"."_k_friendly_name" = "System Settings";

        "klaunchrc"."BusyCursorSettings"."Timeout" = 3;
        "klaunchrc"."TaskbarButtonSettings"."Timeout" = 3;

        "klipperrc"."General"."IgnoreImages" = false;
        "klipperrc"."General"."MaxClipItems" = 30;

        "krunnerrc"."General"."FreeFloating" = true;
        "krunnerrc"."Plugins"."appstreamEnabled" = false;
        "krunnerrc"."Runners.CharacterRunner"."aliases" = "ar";
        "krunnerrc"."Runners.CharacterRunner"."codes" = 002192;
        "krunnerrc"."Runners.CharacterRunner"."triggerWord" = "$";
        "krunnerrc"."Runners.Dictionary"."triggerWord" = "=";
        "krunnerrc"."Runners.Kill Runner"."sorting" = 1;
        "krunnerrc"."Runners.Kill Runner"."triggerWord" = "kill";
        "krunnerrc"."Runners.Kill Runner"."useTriggerWord" = true;
        "krunnerrc"."Runners.krunner_spellcheck"."requireTriggerWord" = true;
        "krunnerrc"."Runners.krunner_spellcheck"."trigger" = "~";

        "kwalletrc"."Wallet"."First Use" = false;

        "kwinrc"."Windows"."BorderlessMaximizedWindows" = true;
        "kwinrc"."Compositing"."LatencyPolicy" = "Medium";
        "kwinrc"."Desktops"."Rows" = 1;
        "kwinrc"."Effect-kwin4_effect_glitch"."Color" = "108,78,70";
        "kwinrc"."Effect-kwin4_effect_glitch"."Duration" = 850;
        "kwinrc"."Effect-kwin4_effect_glitch"."Scale" = 2;
        "kwinrc"."Effect-kwin4_effect_glitch"."Speed" = 0.8;
        "kwinrc"."Effect-kwin4_effect_glitch"."Strength" = 10;
        "kwinrc"."Effect-overview"."BorderActivate" = 7;
        "kwinrc"."Effect-windowview"."BorderActivateAll" = 9;
        "kwinrc"."ElectricBorders"."TopRight" = "LockScreen";
        "kwinrc"."ModifierOnlyShortcuts"."Meta" = "org.kde.kglobalaccel,/component/kwin,org.kde.kglobalaccel.Component,invokeShortcut,Overview";
        "kwinrc"."MouseBindings"."CommandAllWheel" = "Previous/Next Desktop";
        "kwinrc"."NightColor"."Active" = true;
        "kwinrc"."NightColor"."LatitudeAuto" = 48.8909;
        "kwinrc"."NightColor"."LongitudeAuto" = 2.2093;
        "kwinrc"."NightColor"."NightTemperature" = 3800;
        "kwinrc"."Plugins"."bismuthEnabled" = true;
        "kwinrc"."Plugins"."blurEnabled" = true;
        "kwinrc"."Plugins"."contrastEnabled" = true;
        "kwinrc"."Plugins"."diminactiveEnabled" = true;
        "kwinrc"."Plugins"."kwin4_effect_dimscreenEnabled" = true;
        "kwinrc"."Plugins"."kwin4_effect_glitchEnabled" = true;
        "kwinrc"."Plugins"."kwin4_effect_scaleEnabled" = false;
        "kwinrc"."Plugins"."kwin4_effect_translucencyEnabled" = true;
        "kwinrc"."Plugins"."kzonesEnabled" = false;
        "kwinrc"."Script-kzones"."invertedMode" = true;
        "kwinrc"."Script-kzones"."modifierKey" = 0;
        "kwinrc"."Tiling"."padding" = 10;
        # FIXME: escape '.'
        "kwinrc"."Tiling.171a710f-6a25-5610-9384-46e044880bcf"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling.1ab459e4-6e57-5b6a-8a28-c777c1875520"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling.29821dcd-1f9a-5dc9-b1d8-b362bff52f86"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling.2f10540b-652d-583c-8a8f-fb5b2e9db89a"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling.333f372c-ee1d-52cb-ac8d-9cba4bf3d615"."tiles" = "{\"layoutDirection\":\"floating\",\"tiles\":[]}";
        "kwinrc"."Tiling.45cd9a38-5ebb-5e2e-b4f7-9b2187493d7f"."tiles" = "{\"layoutDirection\":\"floating\",\"tiles\":[]}";
        "kwinrc"."Tiling.4656e9c7-29d2-5198-aef7-e64495a298e9"."tiles" = "{\"layoutDirection\":\"floating\",\"tiles\":[]}";
        "kwinrc"."Tiling.92e842d7-5928-5c43-884a-4912e7cc82ed"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling.9941cc6a-0bd0-50e3-bc56-d902f8cdd4b9"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[]}";
        "kwinrc"."Tiling.9afff0fb-844e-5d96-bd2a-4ba3d96d1d04"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling.ad0bc90d-bb0b-5125-a945-21a1f73d8005"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling.afa9781b-7050-56b6-be02-3ba572444cae"."tiles" = "{\"layoutDirection\":\"floating\",\"tiles\":[]}";
        "kwinrc"."Tiling.bc747754-0089-5240-a2ce-b9fb9fdb3a93"."tiles" = "{\"layoutDirection\":\"floating\",\"tiles\":[]}";
        "kwinrc"."Tiling.d4e924a3-3ef3-5ced-98a3-c6e4f235ce8e"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling.dca423e9-0226-5872-988a-5a1ba0043e9d"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[]}";
        "kwinrc"."Tiling.e0e290f5-009f-5e5b-ba02-948f6ba81a95"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[]}";
        "kwinrc"."Tiling.ef4b55d5-5107-5c91-87f7-4cc43cf5e590"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."TouchEdges"."Bottom" = "ApplicationLauncher";
        "kwinrc"."Wayland"."InputMethod[$e]" = "${pkgs.maliit-keyboard}/share/applications/com.github.maliit.keyboard.desktop";
        "kwinrc"."Wayland"."InputMethod\x5b$e\x5d" = "${pkgs.maliit-keyboard}/share/applications/com.github.maliit.keyboard.desktop";
        "kwinrc"."Wayland"."VirtualKeyboardEnabled" = false;
        "kwinrc"."Windows"."CenterSnapZone" = 100;
        "kwinrc"."Windows"."ElectricBorderCooldown" = 400;
        "kwinrc"."Windows"."ElectricBorderDelay" = 350;
        "kwinrc"."Windows"."FocusPolicy" = "FocusFollowsMouse";
        "kwinrc"."Windows"."NextFocusPrefersMouse" = true;
        "kwinrc"."Xwayland"."Scale" = 2;
        "kwinrc"."org\\.kde\\.kdecoration2"."BorderSize" = "Tiny";
        "kwinrc"."org\\.kde\\.kdecoration2"."BorderSizeAuto" = false;
        "kwinrc"."org\\.kde\\.kdecoration2"."ButtonsOnLeft" = "XAI";
        "kwinrc"."org\\.kde\\.kdecoration2"."ButtonsOnRight" = "NHMS";
        "kwinrc"."org\\.kde\\.kdecoration2"."ShowToolTips" = false;
        "kwinrulesrc"."1"."Description" = "Window settings for Color Picker";
        "kwinrulesrc"."1"."size" = "264,157";
        "kwinrulesrc"."1"."sizerule" = 3;
        "kwinrulesrc"."1"."title" = "Color Picker";
        "kwinrulesrc"."1"."titlematch" = 1;
        "kwinrulesrc"."1"."wmclass" = "org.kde.";
        "kwinrulesrc"."1"."wmclassmatch" = 1;
        "kwinrulesrc"."2"."Description" = "Window settings for Firefox — Sharing Indicator";
        "kwinrulesrc"."2"."ignoregeometryrule" = 3;
        "kwinrulesrc"."2"."placement" = 7;
        "kwinrulesrc"."2"."placementrule" = 2;
        "kwinrulesrc"."2"."position" = "1440,1373";
        "kwinrulesrc"."2"."positionrule" = 1;
        "kwinrulesrc"."2"."size" = "77,67";
        "kwinrulesrc"."2"."sizerule" = 3;
        "kwinrulesrc"."2"."title" = "Firefox — Sharing Indicator";
        "kwinrulesrc"."2"."titlematch" = 2;
        "kwinrulesrc"."2"."wmclass" = "firefox firefox";
        "kwinrulesrc"."2"."wmclasscomplete" = true;
        "kwinrulesrc"."2"."wmclassmatch" = 1;
        "kwinrulesrc"."3"."Description" = "Window settings for Firefox — Sharing Indicator";
        "kwinrulesrc"."3"."ignoregeometryrule" = 3;
        "kwinrulesrc"."3"."placement" = 7;
        "kwinrulesrc"."3"."placementrule" = 2;
        "kwinrulesrc"."3"."position" = "1440,1373";
        "kwinrulesrc"."3"."positionrule" = 1;
        "kwinrulesrc"."3"."size" = "77,67";
        "kwinrulesrc"."3"."sizerule" = 3;
        "kwinrulesrc"."3"."title" = "Firefox — Sharing Indicator";
        "kwinrulesrc"."3"."titlematch" = 2;
        "kwinrulesrc"."3"."wmclass" = "firefox firefox";
        "kwinrulesrc"."3"."wmclasscomplete" = true;
        "kwinrulesrc"."3"."wmclassmatch" = 1;
        "kwinrulesrc"."46a0e81f-a0e7-4392-b12a-2456996e87b1"."Description" = "Window settings for Firefox — Sharing Indicator";
        "kwinrulesrc"."46a0e81f-a0e7-4392-b12a-2456996e87b1"."ignoregeometryrule" = 3;
        "kwinrulesrc"."46a0e81f-a0e7-4392-b12a-2456996e87b1"."noborderrule" = 6;
        "kwinrulesrc"."46a0e81f-a0e7-4392-b12a-2456996e87b1"."placement" = 7;
        "kwinrulesrc"."46a0e81f-a0e7-4392-b12a-2456996e87b1"."placementrule" = 1;
        "kwinrulesrc"."46a0e81f-a0e7-4392-b12a-2456996e87b1"."position" = "1440,1373";
        "kwinrulesrc"."46a0e81f-a0e7-4392-b12a-2456996e87b1"."positionrule" = 3;
        "kwinrulesrc"."46a0e81f-a0e7-4392-b12a-2456996e87b1"."size" = "77,67";
        "kwinrulesrc"."46a0e81f-a0e7-4392-b12a-2456996e87b1"."sizerule" = 3;
        "kwinrulesrc"."46a0e81f-a0e7-4392-b12a-2456996e87b1"."title" = "Firefox — Sharing Indicator";
        "kwinrulesrc"."46a0e81f-a0e7-4392-b12a-2456996e87b1"."titlematch" = 2;
        "kwinrulesrc"."46a0e81f-a0e7-4392-b12a-2456996e87b1"."wmclass" = "firefox firefox";
        "kwinrulesrc"."46a0e81f-a0e7-4392-b12a-2456996e87b1"."wmclasscomplete" = true;
        "kwinrulesrc"."46a0e81f-a0e7-4392-b12a-2456996e87b1"."wmclassmatch" = 1;
        "kwinrulesrc"."General"."count" = 2;
        "kwinrulesrc"."General"."rules" = "1,2";
        "kwinrulesrc"."b61ab0ca-a34e-4271-bbe9-b38cee4ea5fd"."Description" = "Window settings for Color Picker";
        "kwinrulesrc"."b61ab0ca-a34e-4271-bbe9-b38cee4ea5fd"."size" = "264,157";
        "kwinrulesrc"."b61ab0ca-a34e-4271-bbe9-b38cee4ea5fd"."sizerule" = 3;
        "kwinrulesrc"."b61ab0ca-a34e-4271-bbe9-b38cee4ea5fd"."title" = "Color Picker";
        "kwinrulesrc"."b61ab0ca-a34e-4271-bbe9-b38cee4ea5fd"."titlematch" = 1;
        "kwinrulesrc"."b61ab0ca-a34e-4271-bbe9-b38cee4ea5fd"."wmclass" = "org.kde.";
        "kwinrulesrc"."b61ab0ca-a34e-4271-bbe9-b38cee4ea5fd"."wmclassmatch" = 1;
        "kwinrulesrc"."d9324897-23cd-4fb6-a297-62b3b8415f65"."Description" = "Window settings for systemsettings";
        "kwinrulesrc"."d9324897-23cd-4fb6-a297-62b3b8415f65"."title" = "Download New .* — System Settings";
        "kwinrulesrc"."d9324897-23cd-4fb6-a297-62b3b8415f65"."type" = 256;
        "kwinrulesrc"."d9324897-23cd-4fb6-a297-62b3b8415f65"."typerule" = 2;
        "kwinrulesrc"."d9324897-23cd-4fb6-a297-62b3b8415f65"."types" = 1;
        "kwinrulesrc"."d9324897-23cd-4fb6-a297-62b3b8415f65"."wmclass" = "systemsettings";
        "kwinrulesrc"."d9324897-23cd-4fb6-a297-62b3b8415f65"."wmclassmatch" = 1;
        "kxkbrc"."Layout"."DisplayNames" = "bé,";
        "kxkbrc"."Layout"."LayoutList" = "fr,fr";
        "kxkbrc"."Layout"."Use" = true;
        "kxkbrc"."Layout"."VariantList" = "bepo,us";
        "plasmanotifyrc"."Notifications"."PopupPosition" = "BottomRight";
        # "plasmarc"."Theme"."name" = "gruvbox";
        "systemsettingsrc"."KFileDialog Settings"."detailViewIconSize" = 16;
        "systemsettingsrc"."Open-with settings"."CompletionMode" = 1;
      };
    };
  };
}
