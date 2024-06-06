{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.programs.graphical.instant-messengers.telegram;
in
{
  options.${namespace}.programs.graphical.instant-messengers.telegram = with types; {
    enable = mkBoolOpt false "Whether or not to enable Telegram.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ telegram-desktop ];
  };
}
