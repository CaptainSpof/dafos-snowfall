{ lib, config, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.apps.qbittorrent;
in
{
  options.dafos.apps.qbittorrent = {
    enable = mkBoolOpt false "Whether or not to enable QBittorent.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      qbittorrent
    ];
  };
}
