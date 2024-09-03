{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:

let
  inherit (lib) mkIf getExe;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.apps.qbittorrent;
  username = config.${namespace}.user.name;
in
{
  options.${namespace}.apps.qbittorrent = {
    enable = mkBoolOpt false "Whether or not to enable qbittorent.";
    nox.enable = mkBoolOpt false "Whether or not to enable qbittorent-nox.";
  };

  config = mkIf cfg.enable {

    systemd.services.qbittorrent = mkIf cfg.nox.enable {
      description = "qBittorrent (headless)";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      serviceConfig = {
        ExecStart = "${getExe pkgs.qbittorrent-nox}";
        User = username;
        Restart = "on-failure";
      };
    };

    environment.systemPackages = with pkgs; [ qbittorrent ];
  };
}
