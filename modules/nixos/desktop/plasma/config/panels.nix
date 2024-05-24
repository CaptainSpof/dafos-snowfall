{ ... }:

{
  programs.plasma = {
    panels = [
      {
        location = "left";
        floating = true;
        height = 60;
        widgets = [
          {
            systemMonitor = {
              title = "CPU Usage";
              sensors = [
                {
                  name = "cpu/all/usage";
                  color = "250,179,135"; # Peach
                }
              ];
              totalSensors = ["cpu/all/usage"];
              textOnlySensors = ["cpu/all/averageTemperature" "cpu/all/averageFrequency"];
            };
          }
          {
            systemMonitor = {
              title = "Memory Usage";
              sensors = [
                {
                  name = "memory/physical/usedPercent";
                  color = "166,227,161"; # Green
                }
              ];
              totalSensors = ["memory/physical/usedPercent"];
              textOnlySensors = ["memory/physical/used" "memory/physical/total"];
            };
          }
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.marginsseparator"
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General = {
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "applications:firefox.desktop"
                  "applications:kitty.desktop"
                  "applications:emacsclient.desktop"
                  "applications:steam.desktop"
                ];
              };
            };
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.panelspacer"
          {
            systemTray = {
              icons.scaleToFit = true;
              items = {
                shown = ["org.kde.plasma.battery"];
                hidden = [];
                configs = {
                  battery.showPercentage = true;
                };
              };
            };
          }
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.pager"
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General = {
                icon = "choice-round";
                paneSwap = "true";
              };
            };
          }
        ];
      }
      # Global menu at the top
      {
        location = "top";
        height = 28;
        floating = true;
        hiding = "autohide";
        widgets = [
          "org.kde.plasma.appmenu"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];

    # configFile = {
    #   "plasma-org.kde.plasma.desktop-appletsrc"."ActionPlugins.0"."MiddleButton;NoModifier" = "org.kde.paste";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."ActionPlugins.0"."RightButton;NoModifier" = "org.kde.contextmenu";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."ActionPlugins.0"."wheel:Vertical;NoModifier" = "org.kde.switchdesktop";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."ActionPlugins.1"."RightButton;NoModifier" = "org.kde.contextmenu";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1"."ItemGeometries-0x0" = "Applet-33:512,80,320,160,0;Applet-32:512,240,384,176,0;Applet-38:1104,800,272,96,0;";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1"."ItemGeometries-1440x900" = "Applet-33:512,80,320,160,0;Applet-32:512,240,384,176,0;Applet-38:1104,800,256,96,0;";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1"."ItemGeometries-1920x1080" = "Applet-33:720,80,368,112,0;Applet-32:704,224,384,176,0;";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1"."ItemGeometries-2048x864" = "Applet-33:816,80,320,160,0;Applet-32:816,240,384,176,0;Applet-38:1712,768,272,96,0;";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1"."ItemGeometries-900x1440" = "Applet-33:240,80,320,160,0;Applet-32:240,512,384,176,0;Applet-38:560,1344,272,96,0;";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1"."ItemGeometriesHorizontal" = "Applet-33:512,80,320,160,0;Applet-32:512,240,384,176,0;Applet-38:1104,800,256,96,0;";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1"."ItemGeometriesVertical" = "Applet-33:240,80,320,160,0;Applet-32:240,512,384,176,0;Applet-38:560,1344,272,96,0;";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1"."activityId" = "1a022626-6b5d-4327-a49f-b39c98e9f964";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1"."formfactor" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1"."lastScreen" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1"."location" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1"."plugin" = "org.kde.plasma.folder";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1"."wallpaperplugin" = "org.kde.slideshow";
    #   # Minimalist Clock
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.32"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.32"."plugin" = "com.github.prayag2.minimalistclock";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.32.Configuration.Appearance"."date_font_family" = "Sarasa Mono Slab TC";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.32.Configuration.Appearance"."date_font_size" = 22;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.32.Configuration.Appearance"."date_letter_spacing" = 12;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.32.Configuration.Appearance"."enable_shadows" = false;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.32.Configuration.Appearance"."frame_border_width" = 8;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.32.Configuration.Appearance"."frame_padding" = 52;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.32.Configuration.Appearance"."time_font_family" = "Sarasa Mono Slab SC";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.32.Configuration.Appearance"."time_font_size" = 82;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.32.Configuration.Appearance"."time_letter_spacing" = 12;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.32.Configuration.Appearance"."time_word_spacing" = 12;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.32.Configuration.ConfigDialog"."DialogHeight" = 614;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.32.Configuration.ConfigDialog"."DialogWidth" = 832;
    #   # System Monitor · CPU
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33"."plugin" = "org.kde.plasma.systemmonitor.cpucore";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration"."CurrentPreset" = "org.kde.plasma.systemmonitor";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration"."UserBackgroundHints" = "ShadowBackground";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.Appearance"."chartFace" = "org.kde.ksysguard.barchart";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.Appearance"."showTitle" = false;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.Appearance"."title" = "Individual Core Usage";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.Appearance"."updateRateLimit" = 1000;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.ConfigDialog"."DialogHeight" = 540;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.ConfigDialog"."DialogWidth" = 720;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.SensorColors"."cpu/cpu.*/usage" = "131,165,152";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.SensorColors"."cpu/cpu0/usage" = "131,165,152";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.SensorColors"."cpu/cpu1/usage" = "131,152,165";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.SensorColors"."cpu/cpu10/usage" = "158,135,206";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.SensorColors"."cpu/cpu11/usage" = "185,135,206";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.SensorColors"."cpu/cpu12/usage" = "206,135,200";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.SensorColors"."cpu/cpu13/usage" = "206,135,174";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.SensorColors"."cpu/cpu14/usage" = "206,135,147";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.SensorColors"."cpu/cpu15/usage" = "206,149,135";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.SensorColors"."cpu/cpu2/usage" = "135,131,165";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.SensorColors"."cpu/cpu3/usage" = "161,131,165";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.SensorColors"."cpu/cpu4/usage" = "165,131,144";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.SensorColors"."cpu/cpu5/usage" = "165,144,131";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.SensorColors"."cpu/cpu6/usage" = "161,165,131";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.SensorColors"."cpu/cpu7/usage" = "135,165,131";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.SensorColors"."cpu/cpu8/usage" = "135,165,206";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.SensorColors"."cpu/cpu9/usage" = "135,138,206";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.Sensors"."highPrioritySensorIds" = "[\"cpu/cpu.*/usage\"]";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.Sensors"."totalSensors" = "[\"cpu/all/usage\"]";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.org.kde.ksysguard.barchart.General"."rangeAuto" = false;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.org.kde.ksysguard.barchart.General"."rangeFrom" = 10;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.org.kde.ksysguard.barchart.General"."showGridLines" = false;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.org.kde.ksysguard.barchart.General"."showLegend" = false;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.33.Configuration.org.kde.ksysguard.barchart.General"."showYAxisLabels" = false;
    #   # Thermal Monitor
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.38"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.38"."plugin" = "org.kde.olib.thermalmonitor";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.38.Configuration"."PreloadWeight" = 55;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.38.Configuration"."UserBackgroundHints" = "ShadowBackground";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.38.Configuration.ConfigDialog"."DialogHeight" = 510;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.38.Configuration.ConfigDialog"."DialogWidth" = 680;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Applets.38.Configuration.General"."sensors" = "[{\"name\":\"GPU Temperature\",\"sensorId\":\"gpu/gpu0/temperature\"},{\"name\":\"Average CPU Temperature\",\"sensorId\":\"cpu/all/averageTemperature\"}]";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.ConfigDialog"."DialogHeight" = 540;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.ConfigDialog"."DialogWidth" = 720;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.General"."ToolBoxButtonX" = 181;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Wallpaper.org.kde.slideshow.General"."Image" = "file:///home/daf/Pictures/wallpapers/pixel-art/pa-landscape-07.gif";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.1.Wallpaper.org.kde.slideshow.General"."SlidePaths" = "/home/daf/Pictures/wallpapers/pixel-art/";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.10.Applets.21.Configuration"."PreloadWeight" = 92;
    #   # Panel
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2"."activityId" = "";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2"."formfactor" = 3;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2"."lastScreen" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2"."location" = 5;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2"."plugin" = "org.kde.panel";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2"."wallpaperplugin" = "org.kde.image";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.19"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.19"."plugin" = "org.kde.plasma.digitalclock";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.19.Configuration"."PreloadWeight" = 60;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.19.Configuration"."popupHeight" = 450;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.19.Configuration"."popupWidth" = 396;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.19.Configuration.Appearance"."autoFontAndSize" = false;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.19.Configuration.Appearance"."dateFormat" = "custom";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.19.Configuration.Appearance"."fontFamily" = "Noto Sans";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.19.Configuration.Appearance"."fontSize" = 8;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.19.Configuration.Appearance"."fontStyleName" = "Regular";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.19.Configuration.ConfigDialog"."DialogHeight" = 540;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.19.Configuration.ConfigDialog"."DialogWidth" = 720;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.25"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.25"."plugin" = "org.kde.plasma.panelspacer";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.26"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.26"."plugin" = "org.kde.plasma.panelspacer";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.27"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.27"."plugin" = "org.kde.nsw_dbus";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.27.Configuration.ConfigDialog"."DialogHeight" = 540;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.27.Configuration.ConfigDialog"."DialogWidth" = 720;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.27.Configuration.General"."decimalPlace" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.27.Configuration.General"."fontSize" = 1.1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.27.Configuration.General"."iconSize" = 0.9;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.27.Configuration.General"."iconType" = "▼ ▲";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.27.Configuration.General"."shortUnits" = true;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.27.Configuration.General"."showSeconds" = false;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.27.Configuration.General"."speedUnits" = "bytes";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.27.Configuration.General"."sufixSize" = 0.8;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.27.Configuration.General"."updateInterval" = 1500;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.27.Configuration.Network"."netSources" = "[{\"path\":\"network/wlp1s0\"\\,\"name\":\"DafWifi - 5Ghz\"\\,\"index\":1\\,\"checked\":true}]";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.28"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.28"."plugin" = "com.github.prayag2.controlcentre";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.28.Configuration"."PreloadWeight" = 65;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.28.Configuration.Appearance"."darkTheme" = "WarmEyes";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.28.Configuration.Appearance"."lightTheme" = "Gruvbox";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.28.Configuration.Appearance"."mainIconName" = "choice-rhomb";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.28.Configuration.ConfigDialog"."DialogHeight" = 540;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.28.Configuration.ConfigDialog"."DialogWidth" = 720;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.29"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.29"."plugin" = "SimpleOverviewPager";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.29.Configuration.ConfigDialog"."DialogHeight" = 540;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.29.Configuration.ConfigDialog"."DialogWidth" = 720;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.3"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.3"."plugin" = "org.kde.plasma.kickoff";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.3.Configuration"."PreloadWeight" = 100;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.3.Configuration"."popupHeight" = 522;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.3.Configuration"."popupWidth" = 653;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.3.Configuration.ConfigDialog"."DialogHeight" = 540;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.3.Configuration.ConfigDialog"."DialogWidth" = 720;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.3.Configuration.General"."favoritesPortedToKAstats" = true;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.3.Configuration.General"."icon" = "choice-round";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.3.Configuration.General"."systemFavorites" = "suspend\\,hibernate\\,reboot\\,shutdown";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.3.Configuration.Shortcuts"."global" = "Alt+F1";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.3.Shortcuts"."global" = "";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.31"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.31"."plugin" = "org.kde.plasma.systemmonitor.memory";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.31.Configuration"."CurrentPreset" = "org.kde.plasma.systemmonitor";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.31.Configuration"."PreloadWeight" = 100;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.31.Configuration.Appearance"."chartFace" = "org.kde.ksysguard.linechart";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.31.Configuration.Appearance"."title" = "Memory Usage";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.31.Configuration.ConfigDialog"."DialogHeight" = 540;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.31.Configuration.ConfigDialog"."DialogWidth" = 720;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.31.Configuration.SensorColors"."memory/physical/used" = "214,93,14";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.31.Configuration.Sensors"."highPrioritySensorIds" = "[\"memory/physical/used\"]";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.31.Configuration.Sensors"."lowPrioritySensorIds" = "[\"memory/physical/total\"]";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.31.Configuration.Sensors"."totalSensors" = "[\"memory/physical/usedPercent\"]";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.31.Configuration.org.kde.ksysguard.linechart.General"."lineChartFillOpacity" = 50;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.31.Configuration.org.kde.ksysguard.linechart.General"."lineChartSmooth" = false;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.31.Configuration.org.kde.ksysguard.linechart.General"."showGridLines" = false;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.31.Configuration.org.kde.ksysguard.linechart.General"."showLegend" = false;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.31.Configuration.org.kde.ksysguard.linechart.General"."showYAxisLabels" = false;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.34"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.34"."plugin" = "org.kde.plasma.marginsseparator";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.35"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.35"."plugin" = "org.kde.plasma.marginsseparator";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.5"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.5"."plugin" = "org.kde.plasma.icontasks";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.5.Configuration.General"."launchers" = "applications:systemsettings.desktop,preferred://filemanager,preferred://browser,file:///etc/profiles/per-user/daf/share/applications/emacs.desktop,file:///etc/profiles/per-user/daf/share/applications/kitty.desktop";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.6"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.6"."plugin" = "org.kde.plasma.marginsseparator";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.7"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.7"."plugin" = "org.kde.plasma.systemtray";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.7.Configuration"."PreloadWeight" = 90;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.Applets.7.Configuration"."SystrayContainmentId" = 8;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.ConfigDialog"."DialogHeight" = 900;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.ConfigDialog"."DialogWidth" = 171;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.2.General"."AppletOrder" = "28;34;29;27;26;5;25;31;35;7;19;6;3";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.39"."ItemGeometries-1440x900" = "";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.39"."ItemGeometries-2048x864" = "";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.39"."ItemGeometriesHorizontal" = "";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.39"."activityId" = "1a022626-6b5d-4327-a49f-b39c98e9f964";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.39"."formfactor" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.39"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.39"."lastScreen" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.39"."location" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.39"."plugin" = "org.kde.plasma.folder";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.39"."wallpaperplugin" = "org.kde.image";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.39.General"."ToolBoxButtonX" = 181;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.40"."activityId" = "1a022626-6b5d-4327-a49f-b39c98e9f964";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.40"."formfactor" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.40"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.40"."lastScreen" = 2;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.40"."location" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.40"."plugin" = "org.kde.plasma.folder";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.40"."wallpaperplugin" = "org.kde.image";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.41"."ItemGeometries-0x0" = "";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.41"."ItemGeometries-1440x900" = "";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.41"."ItemGeometriesHorizontal" = "";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.41"."activityId" = "7275591f-1412-4b64-a012-a11462efd787";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.41"."formfactor" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.41"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.41"."lastScreen" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.41"."location" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.41"."plugin" = "org.kde.plasma.folder";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.41"."wallpaperplugin" = "org.kde.image";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.42"."ItemGeometries-0x0" = "";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.42"."ItemGeometriesHorizontal" = "";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.42"."activityId" = "7275591f-1412-4b64-a012-a11462efd787";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.42"."formfactor" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.42"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.42"."lastScreen" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.42"."location" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.42"."plugin" = "org.kde.plasma.folder";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.42"."wallpaperplugin" = "org.kde.image";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.43"."activityId" = "7275591f-1412-4b64-a012-a11462efd787";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.43"."formfactor" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.43"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.43"."lastScreen" = 2;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.43"."location" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.43"."plugin" = "org.kde.plasma.folder";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.43"."wallpaperplugin" = "org.kde.image";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44"."activityId" = "";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44"."formfactor" = 3;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44"."lastScreen" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44"."location" = 5;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44"."plugin" = "org.kde.panel";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44"."wallpaperplugin" = "org.kde.image";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.45"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.45"."plugin" = "org.kde.plasma.kickoff";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.45.Configuration"."PreloadWeight" = 100;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.45.Configuration"."popupHeight" = 514;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.45.Configuration"."popupWidth" = 647;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.45.Configuration.ConfigDialog"."DialogHeight" = 510;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.45.Configuration.ConfigDialog"."DialogWidth" = 680;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.45.Configuration.General"."favoritesPortedToKAstats" = true;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.45.Configuration.General"."onicon" = "choice-round";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.45.Configuration.General"."systemFavorites" = "suspend\\,hibernate\\,reboot\\,shutdown";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.45.Configuration.Shortcuts"."global" = "Alt+F1";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.47"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.47"."plugin" = "org.kde.plasma.icontasks";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.47.Configuration.ConfigDialog"."DialogHeight" = 510;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.47.Configuration.ConfigDialog"."DialogWidth" = 680;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.47.Configuration.General"."launchers" = "applications:systemsettings.desktop,preferred://filemanager,preferred://browser,file:///etc/profiles/per-user/daf/share/applications/emacsclient.desktop,file:///etc/profiles/per-user/daf/share/applications/kitty.desktop,file:///run/current-system/sw/share/applications/steam.desktop,file:///run/current-system/sw/share/applications/org.telegram.desktop.desktop";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.48"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.48"."plugin" = "org.kde.plasma.marginsseparator";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.49"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.49"."plugin" = "org.kde.plasma.systemtray";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.49.Configuration"."PreloadWeight" = 65;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.49.Configuration"."SystrayContainmentId" = 50;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.61"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.61"."plugin" = "org.kde.plasma.digitalclock";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.61.Configuration.Appearance"."autoFontAndSize" = false;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.61.Configuration.Appearance"."dateFormat" = "custom";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.61.Configuration.Appearance"."fontFamily" = "Sarasa UI CL";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.61.Configuration.Appearance"."fontSize" = 8;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.61.Configuration.Appearance"."fontStyleName" = "Regular";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.61.Configuration.ConfigDialog"."DialogHeight" = 599;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.61.Configuration.ConfigDialog"."DialogWidth" = 704;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.68"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.68"."plugin" = "SimpleOverviewPager";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.69"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.69"."plugin" = "org.kde.plasma.panelspacer";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.70"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.70"."plugin" = "com.github.prayag2.controlcentre";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.70.Configuration"."PreloadWeight" = 55;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.70.Configuration.Appearance"."mainIconName" = "choice-rhomb";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.70.Configuration.ConfigDialog"."DialogHeight" = 510;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.70.Configuration.ConfigDialog"."DialogWidth" = 680;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.71"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.71"."plugin" = "org.kde.plasma.panelspacer";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.72"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.72"."plugin" = "org.kde.plasma.marginsseparator";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.73"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.Applets.73"."plugin" = "org.kde.plasma.marginsseparator";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.ConfigDialog"."DialogHeight" = 900;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.ConfigDialog"."DialogWidth" = 171;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.44.General"."AppletOrder" = "70;68;72;69;73;47;48;71;49;61;45";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50"."activityId" = "";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50"."formfactor" = 3;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50"."lastScreen" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50"."location" = 5;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50"."plugin" = "org.kde.plasma.private.systemtray";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50"."popupHeight" = 432;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50"."popupWidth" = 432;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50"."wallpaperplugin" = "org.kde.image";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.51"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.51"."plugin" = "org.kde.plasma.clipboard";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.52"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.52"."plugin" = "org.kde.plasma.notifications";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.53"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.53"."plugin" = "org.kde.plasma.manage-inputmethod";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.54"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.54"."plugin" = "org.kde.plasma.devicenotifier";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.55"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.55"."plugin" = "org.kde.plasma.keyboardlayout";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.56"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.56"."plugin" = "org.kde.kscreen";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.57"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.57"."plugin" = "org.kde.plasma.keyboardindicator";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.58"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.58"."plugin" = "org.kde.kdeconnect";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.59"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.59"."plugin" = "org.kde.plasma.volume";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.59.Configuration.General"."migrated" = true;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.60"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.60"."plugin" = "org.kde.plasma.printmanager";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.63"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.63"."plugin" = "org.kde.plasma.mediacontroller";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.63.Configuration"."PreloadWeight" = 34;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.64"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.64"."plugin" = "org.kde.plasma.nightcolorcontrol";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.64.Configuration"."PreloadWeight" = 26;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.65"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.65"."plugin" = "org.kde.plasma.battery";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.66"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.66"."plugin" = "org.kde.plasma.networkmanagement";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.66.Configuration"."PreloadWeight" = 42;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.67"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.67"."plugin" = "org.kde.plasma.bluetooth";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.67.Configuration"."PreloadWeight" = 23;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.75"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.Applets.75"."plugin" = "touchpad";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.ConfigDialog"."DialogHeight" = 510;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.ConfigDialog"."DialogWidth" = 680;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.General"."extraItems" = "org.kde.plasma.clipboard,org.kde.plasma.notifications,org.kde.plasma.mediacontroller,org.kde.plasma.manage-inputmethod,org.kde.plasma.devicenotifier,org.kde.plasma.nightcolorcontrol,org.kde.plasma.networkmanagement,org.kde.plasma.bluetooth,org.kde.kscreen,org.kde.plasma.keyboardindicator,org.kde.kdeconnect,org.kde.plasma.volume,org.kde.plasma.printmanager,org.kde.plasma.keyboardlayout,org.kde.plasma.battery,touchpad";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.General"."hiddenItems" = "org.kde.plasma.keyboardlayout,org.kde.kscreen,org.kde.plasma.battery,touchpad,org.kde.plasma.manage-inputmethod";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.50.General"."knownItems" = "org.kde.plasma.clipboard,org.kde.plasma.notifications,org.kde.plasma.mediacontroller,org.kde.plasma.manage-inputmethod,org.kde.plasma.battery,org.kde.plasma.devicenotifier,org.kde.plasma.keyboardlayout,org.kde.plasma.nightcolorcontrol,org.kde.plasma.networkmanagement,org.kde.plasma.bluetooth,org.kde.kscreen,org.kde.plasma.keyboardindicator,org.kde.kdeconnect,org.kde.plasma.volume,org.kde.plasma.printmanager";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8"."activityId" = "";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8"."formfactor" = 3;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8"."lastScreen" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8"."location" = 5;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8"."plugin" = "org.kde.plasma.private.systemtray";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8"."popupHeight" = 432;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8"."popupWidth" = 432;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8"."wallpaperplugin" = "org.kde.image";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.10"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.10"."plugin" = "org.kde.plasma.notifications";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.10.Configuration"."PreloadWeight" = 100;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.11"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.11"."plugin" = "org.kde.plasma.clipboard";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.11.Configuration"."PreloadWeight" = 80;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.12"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.12"."plugin" = "org.kde.plasma.devicenotifier";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.13"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.13"."plugin" = "org.kde.plasma.keyboardindicator";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.14"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.14"."plugin" = "org.kde.kscreen";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.14.Configuration"."PreloadWeight" = 55;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.15"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.15"."plugin" = "org.kde.plasma.printmanager";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.16"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.16"."plugin" = "org.kde.kdeconnect";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.16.Configuration"."PreloadWeight" = 65;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.17"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.17"."plugin" = "org.kde.plasma.volume";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.17.Configuration"."PreloadWeight" = 100;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.17.Configuration.General"."migrated" = true;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.18"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.18"."plugin" = "org.kde.plasma.keyboardlayout";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.21"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.21"."plugin" = "org.kde.plasma.nightcolorcontrol";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.21.Configuration"."PreloadWeight" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.22"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.22"."plugin" = "org.kde.plasma.battery";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.22.Configuration"."PreloadWeight" = 65;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.23"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.23"."plugin" = "org.kde.plasma.networkmanagement";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.23.Configuration"."PreloadWeight" = 62;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.24"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.24"."plugin" = "org.kde.plasma.bluetooth";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.24.Configuration"."PreloadWeight" = 96;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.30"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.30"."plugin" = "org.kde.plasma.manage-inputmethod";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.39"."immutability" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.39"."plugin" = "org.kde.plasma.mediacontroller";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.39.Configuration"."PreloadWeight" = 0;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.Applets.9.Configuration"."PreloadWeight" = 42;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.ConfigDialog"."DialogHeight" = 540;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.ConfigDialog"."DialogWidth" = 720;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.General"."extraItems" = "org.kde.plasma.mediacontroller,org.kde.plasma.notifications,org.kde.plasma.battery,org.kde.plasma.clipboard,org.kde.plasma.devicenotifier,org.kde.plasma.keyboardindicator,org.kde.kscreen,org.kde.plasma.printmanager,org.kde.kdeconnect,org.kde.plasma.volume,org.kde.plasma.bluetooth,org.kde.plasma.keyboardlayout,org.kde.plasma.nightcolorcontrol,org.kde.plasma.networkmanagement,org.kde.plasma.manage-inputmethod";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.General"."hiddenItems" = "org.kde.plasma.keyboardlayout,org.kde.plasma.nightcolorcontrol";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.General"."iconSpacing" = 1;
    #   "plasma-org.kde.plasma.desktop-appletsrc"."Containments.8.General"."knownItems" = "org.kde.plasma.manage-inputmethod,org.kde.plasma.mediacontroller,org.kde.plasma.notifications,org.kde.plasma.battery,org.kde.plasma.clipboard,org.kde.plasma.devicenotifier,org.kde.plasma.keyboardindicator,org.kde.kscreen,org.kde.plasma.printmanager,org.kde.kdeconnect,org.kde.plasma.volume,org.kde.plasma.bluetooth,org.kde.plasma.keyboardlayout,org.kde.plasma.nightcolorcontrol,org.kde.plasma.networkmanagement";
    #   "plasma-org.kde.plasma.desktop-appletsrc"."ScreenMapping"."itemsOnDisabledScreens" = "";
    # };
  };
}
