{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.apps.jellyfin-media-player;
in
{
  options.dafos.apps.jellyfin-media-player = with types; {
    enable = mkBoolOpt false "Whether or not to enable jellyfin-media-player.";
  };

  config = mkIf cfg.enable { environment.systemPackages = with pkgs; [ jellyfin-media-player ]; };
}
