{ config, lib, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.plasma.panels;
in
{
  options.${namespace}.desktop.plasma.panels = with types; {
    enable = mkBoolOpt true "Whether or not to configure plasma panels.";
    launchers = mkOpt (listOf str)
      [
        "applications:org.kde.dolphin.desktop"
        "applications:firefox-beta.desktop"
        "applications:kitty.desktop"
        "applications:emacsclient.desktop"
      ] "The launchers to display in the panel.";
  };

  config = mkIf cfg.enable {
    dafos.home.extraOptions = {
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
                  displayStyle = "org.kde.ksysguard.linechart";
                  sensors = [
                    {
                      name = "cpu/all/usage";
                      color = "250,179,135"; # Peach
                      label = "CPU Usage";
                    }
                  ];
                  totalSensors = ["cpu/all/usage"];
                  textOnlySensors = ["cpu/all/averageTemperature" "cpu/all/averageFrequency"];
                };
              }
              {
                systemMonitor = {
                  title = "Memory Usage";
                  displayStyle = "org.kde.ksysguard.linechart";
                  sensors = [
                    {
                      name = "memory/physical/usedPercent";
                      color = "166,227,161"; # Green
                      label = "Memory Usage";
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
                    launchers = cfg.launchers;
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
      };
    };
  };
}
