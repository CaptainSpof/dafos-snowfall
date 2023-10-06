{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.tools.bottom;
in
{
  options.dafos.tools.bottom = with types; {
    enable = mkBoolOpt false "Whether or not to enable Bottom.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bottom
    ];

    dafos.home.extraOptions = {
      home.shellAliases = {
        htop = "btm -b";
      };
    };
  };
}
