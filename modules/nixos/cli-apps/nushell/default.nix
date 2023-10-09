{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.cli-apps.nushell;
in
{
  options.dafos.cli-apps.nushell = with types; {
    enable = mkBoolOpt false "Whether or not to enable Nushell.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.nushell ];
  };
}
