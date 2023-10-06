{ lib, pkgs, config, ... }:

let
  cfg = config.dafos.apps.steamtinkerlaunch;

  inherit (lib) mkIf mkEnableOption;
in
{
  options.dafos.apps.steamtinkerlaunch = {
    enable = mkEnableOption "Steam Tinker Launch";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      steamtinkerlaunch
    ];
  };
}
