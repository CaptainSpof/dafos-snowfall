{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:

let
  inherit (lib) mkIf package;
  inherit (lib.${namespace}) mkOpt mkBoolOpt;

  cfg = config.${namespace}.desktop.addons.term;
in
{
  options.${namespace}.desktop.addons.term = {
    enable = mkBoolOpt false "Whether to enable the gnome terminal.";
    pkg = mkOpt package pkgs.kitty "The terminal to install.";
  };

  config = mkIf cfg.enable { environment.systemPackages = [ cfg.pkg ]; };
}
