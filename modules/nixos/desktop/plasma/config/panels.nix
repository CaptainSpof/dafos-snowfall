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
  };
}
