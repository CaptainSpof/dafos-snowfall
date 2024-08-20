{ config, lib, namespace, ... }:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.suites.yahrr;
in
{
  options.${namespace}.suites.yahrr = {
    enable = mkBoolOpt false "Whether or not to enable yahrr configuration.";
  };

  config = mkIf cfg.enable {
    dafos = {
      services = {
        jellyfin = enabled;
        prowlarr = enabled;
        radarr = enabled;
        readarr = enabled;
        sonarr = enabled;
      };
      apps = {
        qbittorrent = {
          enable = true;
          nox.enable = true;
        };
      };
    };
  };
}
