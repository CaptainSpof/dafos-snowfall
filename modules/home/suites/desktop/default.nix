{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.suites.desktop;
in
{
  options.${namespace}.suites.desktop = {
    enable = mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ smile ];

    dafos = {
      desktop = {
        plasma = {
          enable = true;
          config = enabled;
          desktop = enabled;
          kwin = enabled;
          panels = enabled;
          shortcuts = enabled;
          theme = enabled;
        };
        addons = {
          wallpapers = enabled;
        };
      };
    };
  };
}
