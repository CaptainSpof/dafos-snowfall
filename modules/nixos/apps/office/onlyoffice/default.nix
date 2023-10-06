{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.apps.office.onlyoffice;
in
{
  options.dafos.apps.office.onlyoffice = with types; {
    enable = mkBoolOpt false "Whether or not to enable OnlyOffice.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ onlyoffice-bin ];
  };
}
