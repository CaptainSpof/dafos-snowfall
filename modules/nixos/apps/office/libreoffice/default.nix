{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.apps.office.libreoffice;
in
{
  options.dafos.apps.office.libreoffice = with types; {
    enable = mkBoolOpt false "Whether or not to enable Libreoffice.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ libreoffice ];
  };
}
