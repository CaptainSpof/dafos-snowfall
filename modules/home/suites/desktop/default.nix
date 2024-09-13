{
  config,
  lib,
  namespace,
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
