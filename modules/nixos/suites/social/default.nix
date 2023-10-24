{ config, lib, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.suites.social;
in {
  options.dafos.suites.social = with types; {
    enable = mkBoolOpt false "Whether or not to enable social configuration.";
  };

  config = mkIf cfg.enable {
    dafos = {
      apps = {
        discord = { enable = true; };
        element = disabled;
        telegram = enabled;
      };
    };
  };
}
