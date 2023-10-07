{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.cli-apps.zellij;
in
{
  options.dafos.cli-apps.zellij = with types; {
    enable = mkBoolOpt false "Whether or not to enable Zellij.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ zellij ];
  };
}
