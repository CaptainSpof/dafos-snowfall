{
  config,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.desktop.plasma.desktop;
in
{
  options.${namespace}.desktop.plasma.desktop = {
    enable = mkBoolOpt true "Whether or not to configure plasma panels.";
  };

  config = mkIf cfg.enable {
    dafos.home.extraOptions = {
      programs.plasma = {
        desktop.widgets = [
          {
            digitalClock = {
              position = {
                horizontal = 1650;
                vertical = 40;
              };
              size = {
                width = 225;
                height = 200;
              };

              # Digital clock settings
              calendar = {
                firstDayOfWeek = "monday";
                plugins = [
                  "astronomicalevents"
                  "holidaysevents"
                ];
                showWeekNumbers = true;
              };

              date = {
                enable = true;
                format = "longDate";
                position = "belowTime";
              };

              time = {
                format = "24h";
                showSeconds = "never";
              };
            };
          }
        ];
      };
    };
  };
}
