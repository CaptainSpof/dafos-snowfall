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

  cfg = config.${namespace}.programs.graphical.instant-messengers.element;
in
{
  options.${namespace}.programs.graphical.instant-messengers.element = {
    enable = mkBoolOpt false "Whether or not to enable element.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ element-desktop ]; };
}
