{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.suites.yahrr;
in
{
  options.dafos.suites.yahrr = with types; {
    enable = mkBoolOpt false "Whether or not to enable yahrr configuration.";
  };

  config = mkIf cfg.enable {
    dafos = {
      services = {
        jellyfin = enabled;
        radarr = enabled;
        readarr = enabled;
        sonarr = enabled;
      };
    };
  };
}
