{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.office.libreoffice;
in
{
  options.${namespace}.apps.office.libreoffice = with types; {
    enable = mkBoolOpt false "Whether or not to enable libreoffice.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ libreoffice ];
  };
}
