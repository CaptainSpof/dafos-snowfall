{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.cli-apps.zellij;
in
{
  options.${namespace}.cli-apps.zellij = with types; {
    enable = mkBoolOpt false "Whether or not to enable Zellij.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ zellij ];
  };
}
