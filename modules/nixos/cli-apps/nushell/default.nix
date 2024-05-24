{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.cli-apps.nushell;
in
{
  options.${namespace}.cli-apps.nushell = with types; {
    enable = mkBoolOpt false "Whether or not to enable Nushell.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.nushell ];
  };
}
