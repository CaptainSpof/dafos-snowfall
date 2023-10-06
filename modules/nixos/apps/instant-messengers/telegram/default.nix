{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.apps.telegram;
in
{
  options.dafos.apps.telegram = with types; {
    enable = mkBoolOpt false "Whether or not to enable Telegram.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ telegram-desktop ];
  };
}
