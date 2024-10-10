{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:

let
  inherit (lib) mkIf getExe;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.services.koi;
in
{
  options.${namespace}.services.koi = {
    enable = mkBoolOpt false "Whether or not to enable koi.";
  };

  config = mkIf cfg.enable {
    systemd.user.services.koi = {
      Unit = {
        Description = "koi";
        After = [ "plasma-workspace.target" ];
      };

      Install = {
        WantedBy = [ "plasma-workspace.target" ];
      };

      Service = {
        ExecStart = "${getExe pkgs.kdePackages.koi}";
        Restart = "on-failure";
      };
    };

    xdg.configFile."koirc".text = lib.generators.toINIWithGlobalSection { } {
      globalSection = { };
      sections = {
        General = {
          notify = 2;
          schedule = 2;
          schedule-type = "sun";
          start-hidden = 2;
        };
        ColorScheme = {
          enabled = true;
          dark = "${pkgs.kde-gruvbox}/share/color-schemes/Gruvbox.colors";
          light = "${pkgs.dafos.kde-warm-eyes}/share/color-schemes/WarmEyes.colors";
        };
        GTKTheme = {
          enabled = true;
          dark = "Gruvbox-Dark";
          light = "Gruvbox-Light";
        };
        IconTheme = {
          dark = "Papirus";
          enabled = true;
          light = "Papirus-Light";
        };
      };
    };
  };
}
