{ lib, config, ... }:

let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.dafos.cli-apps.nushell;
in
{
  options.dafos.cli-apps.nushell = {
    enable = mkEnableOption "Nushell";
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
