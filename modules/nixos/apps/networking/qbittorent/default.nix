{ lib, config, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.apps.qbittorrent;
  username = config.dafos.vars.username;
in
{
  options.dafos.apps.qbittorrent = {
    enable = mkBoolOpt false "Whether or not to enable QBittorent.";
    nox.enable = mkBoolOpt false "Whether or not to enable QBittorent no X.";
  };

  config = mkIf cfg.enable {

    systemd.services.qbittorrent = mkIf cfg.nox.enable {
      description = "qBittorrent (headless)";
      wantedBy = ["multi-user.target"];
      after = ["network.target"];

      serviceConfig = {
        ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox";
        User = username;
        Restart = "on-failure";
      };
    };

    environment.systemPackages = with pkgs; [
      qbittorrent
    ];
  };
}
