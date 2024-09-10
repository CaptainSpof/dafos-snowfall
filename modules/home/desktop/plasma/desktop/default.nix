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
    enable = mkBoolOpt false "Whether or not to configure plasma desktop.";
  };

  config = mkIf cfg.enable {
    programs.plasma = {
      desktop.widgets = [
        {
          digitalClock = {
            position = {
              horizontal = 1500;
              vertical = 80;
            };

            size = {
              width = 200;
              height = 150;
            };

            calendar = {
              plugins = [
                "astronomicalevents"
                "holidaysevents"
              ];
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
}
