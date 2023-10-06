{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.desktop.addons.term;
in
{
  options.dafos.desktop.addons.term = with types; {
    enable = mkBoolOpt false "Whether to enable the gnome terminal.";
    pkg = mkOpt package pkgs.foot "The terminal to install.";
  };

  config = mkIf cfg.enable { environment.systemPackages = [ cfg.pkg ]; };
}
