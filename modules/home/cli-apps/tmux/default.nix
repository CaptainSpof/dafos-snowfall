{ lib, config, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.cli-apps.tmux;
in
{
  options.dafos.cli-apps.tmux = {
    enable = mkEnableOption "Tmux";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dafos.tmux
    ];
  };
}
