{ lib, config, namespace, ... }:

let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.cli-apps.nushell;
in
{
  options.${namespace}.cli-apps.nushell = {
    enable = mkEnableOption "Whether or not to enable Nushell";
  };

  config = mkIf cfg.enable {
    programs = {
      nushell = {
        enable = true;
        configFile.source = ./config.nu;
      };

      carapace = {
        enable = true;
        enableNushellIntegration = true;
      };
    };
  };
}
