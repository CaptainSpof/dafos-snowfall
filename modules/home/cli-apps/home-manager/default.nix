{ lib, config, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.dafos) enabled;

  cfg = config.dafos.cli-apps.home-manager;
in
{
  options.dafos.cli-apps.home-manager = {
    enable = mkEnableOption "home-manager";
  };

  config = mkIf cfg.enable {
    programs.home-manager = enabled;
  };
}
