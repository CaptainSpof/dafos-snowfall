{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.suites.games;
  apps = {
    bottles = enabled;
    gamemode = enabled;
    lutris = enabled;
    prismlauncher = enabled;
    protontricks = enabled;
    steam = enabled;
    winetricks = enabled;
  };
  cli-apps = {
    wine = enabled;
    proton = enabled;
  };
in
{
  options.dafos.suites.games = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common games configuration.";
  };

  config = mkIf cfg.enable { dafos = { inherit apps cli-apps; }; };
}
