{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.office.onlyoffice;
in
{
  options.${namespace}.apps.office.onlyoffice = with types; {
    enable = mkBoolOpt false "Whether or not to enable OnlyOffice.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ onlyoffice-bin ];
  };
}
