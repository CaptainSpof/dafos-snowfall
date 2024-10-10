{
  config,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.bottom;
in
{
  options.${namespace}.programs.terminal.tools.bottom = {
    enable = mkBoolOpt false "Whether or not to enable bottom.";
  };

  config = mkIf cfg.enable {
    programs.bottom = {
      enable = true;

      settings = {
        flags = {
          temperature_type = "c";
        };
        theme = "gruvbox";
      };
    };

    home.shellAliases = {
      htop = "btm -b";
    };
  };
}
