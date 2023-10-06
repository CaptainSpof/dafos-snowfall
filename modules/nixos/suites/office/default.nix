{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.suites.office;
in {
  options.dafos.suites.office = with types; {
    enable = mkBoolOpt false "Whether or not to enable office configuration.";
  };

  config = mkIf cfg.enable {
    dafos = {
      apps.office = {
        libreoffice = enabled;
        onlyoffice = disabled;
      };
    };
  };
}
