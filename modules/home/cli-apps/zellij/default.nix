{ lib, config, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.cli-apps.zellij;
in
{
  options.dafos.cli-apps.zellij = {
    enable = mkEnableOption "Whether or not to enable zellij.";
  };

  config = mkIf cfg.enable {

    programs.zellij = {
      enable = true;
      enableFishIntegration = true;
    };

    home.file.".config/zellij" = {
      source = ./config;
      recursive = true;
    };
  };
}
