{ lib, config, pkgs, ... }:

let
  cfg = config.dafos.services.logiops;

  inherit (lib) mkEnableOption mkIf;
in
{
  options.dafos.services.logiops = {
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
      enable = true;
      description = "Logitech Configuration Daemon.";
      wantedBy = [ "graphical.target" ];
      serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
        ExecStart = "${pkgs.logiops}/bin/logid -c " + ./logid.cfg;
      };
    };
  };
}
