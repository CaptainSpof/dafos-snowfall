{ lib, config, pkgs, namespace, ... }:

let
  cfg = config.${namespace}.services.logiops;

  inherit (lib) mkEnableOption mkIf;
in
{
  options.${namespace}.services.logiops = {
    enable = mkEnableOption "Logiops";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.logiops ];

    services.udev.packages = [ pkgs.logitech-udev-rules ];
    services.udev.extraRules = ''
      KERNEL=="uinput", GROUP="input", MODE:="0660", OPTIONS+="static_node=uinput"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="046d", MODE="0660", GROUP="input"
    '';

    systemd.services.logid = {
      description = "Logitech Configuration Daemon.";
      wantedBy = [ "graphical.target" ];
      after = [ "multi-user.target" ];
      wants = [ "multi-user.target" ];
      startLimitIntervalSec = 0;
      serviceConfig = {
        Type = "simple";
        ExecStartPre = "${pkgs.kmod}/bin/modprobe hid_logitech_hidpp";
        ExecStart = "${pkgs.logiops}/bin/logid -c " + ./logid.cfg;
        ExecReload = "/bin/kill -HUP $MAINPID";
        Restart = "on-failure";
      };
    };
  };
}
