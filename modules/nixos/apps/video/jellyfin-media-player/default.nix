{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.jellyfin-media-player;
in
{
  options.${namespace}.apps.jellyfin-media-player = with types; {
    enable = mkBoolOpt false "Whether or not to enable jellyfin-media-player.";
  };

  config = mkIf cfg.enable { environment.systemPackages = with pkgs; [ jellyfin-media-player ]; };
}
