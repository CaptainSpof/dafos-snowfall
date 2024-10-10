{
  config,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkOpt mkBoolOpt;

  cfg = config.${namespace}.desktop.plasma.desktop;
in
{
  options.${namespace}.desktop.plasma.desktop = with types; {
    enable = mkBoolOpt false "Whether or not to configure plasma desktop.";

    digitalClock = {
      position = {
        horizontal = mkOpt number 1600 "The horizontal position of the widget.";
        vertical = mkOpt number 80 "The vertical position of the widget.";
      };
    };
  };

  config = mkIf cfg.enable {
    programs.plasma = {
      desktop.widgets = [
        {
          digitalClock = {
            inherit (cfg.digitalClock) position;

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
