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

  cfg = config.${namespace}.programs.graphical.instant-messengers.telegram;
in
{
  options.${namespace}.programs.graphical.instant-messengers.telegram = {
    enable = mkBoolOpt false "Whether or not to enable telegram.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ telegram-desktop ]; };
}
