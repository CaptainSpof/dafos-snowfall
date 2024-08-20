{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.flake;
in
{
  options.${namespace}.programs.terminal.tools.flake = {
    enable = mkBoolOpt false "Whether or not to enable flake.";
  };

  config = mkIf cfg.enable { environment.systemPackages = with pkgs; [ snowfallorg.flake ]; };
}
