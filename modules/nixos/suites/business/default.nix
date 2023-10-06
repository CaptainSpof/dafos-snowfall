{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.suites.business;
in
{
  options.dafos.suites.business = with types; {
    enable = mkBoolOpt false "Whether or not to enable business configuration.";
  };

  config =
    mkIf cfg.enable { dafos = { apps = { frappe-books = enabled; }; }; };
}
