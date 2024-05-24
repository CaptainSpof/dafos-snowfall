{ config, lib, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.office;
in {
  options.${namespace}.suites.office = with types; {
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
