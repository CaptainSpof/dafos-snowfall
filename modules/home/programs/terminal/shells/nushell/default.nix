{
  lib,
  config,
  namespace,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.programs.terminal.shells.nushell;
in
{
  options.${namespace}.programs.terminal.shells.nushell = {
    enable = mkEnableOption "Whether or not to enable nushell.";
  };

  config = mkIf cfg.enable {
    programs = {
      nushell = {
        enable = true;
        configFile.source = ./config.nu;
      };
    };
  };
}
