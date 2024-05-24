{ lib, config, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.expressvpn;
in
{
  options.${namespace}.apps.expressvpn = {
    enable = mkBoolOpt false "Whether or not to enable ExpressVPN.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dafos.expressvpn
    ] ++ optionals config.${namespace}.desktop.gnome.enable [
      gnomeExtensions.evpn-shell-assistant
    ];

    boot.kernelModules = [ "tun" ];

    systemd.services.expressvpn = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" "network-online.target" ];

      description = "ExpressVPN Daemon";

      serviceConfig = {
        ExecStart = "${pkgs.dafos.expressvpn}/bin/expressvpnd";
        Restart = "on-failure";
        RestartSec = 5;
      };
    };
  };
}
