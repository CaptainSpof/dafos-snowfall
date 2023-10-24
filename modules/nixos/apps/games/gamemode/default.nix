{ config, lib, ... }:
let
  inherit (lib) types mkIf;
  inherit (lib.dafos) mkBoolOpt mkOpt;

  cfg = config.dafos.apps.gamemode;
in {
  options.dafos.apps.gamemode = with types; {
    enable = mkBoolOpt false "Whether or not to enable gamemode.";
    endscript =
      mkOpt (nullOr str) null "The script to run when disabling gamemode.";
    startscript =
      mkOpt (nullOr str) null "The script to run when enabling gamemode.";
  };

  config = mkIf cfg.enable {
    programs.gamemode = {
      enable = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 15;
        };
      };
    };
  };
}
