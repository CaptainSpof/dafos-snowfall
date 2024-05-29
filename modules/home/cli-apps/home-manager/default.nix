{ lib, config, namespace, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.cli-apps.home-manager;
in
{
  options.${namespace}.cli-apps.home-manager = {
    enable = mkEnableOption "Whether or not to enable Home Manager";
  };

  config = mkIf cfg.enable {
    programs.home-manager = enabled;
  };
}
