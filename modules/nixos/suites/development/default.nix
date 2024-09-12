{
  config,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.suites.development;
in
{
  options.${namespace}.suites.development = {
    enable = mkBoolOpt false "Whether or not to enable common development configuration.";
    podman.enable = mkBoolOpt false "Whether or not to enable podman development configuration.";
    keyboard.enable = mkBoolOpt false "Whether or not to enable keyboard development configuration.";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [
      12345
      3000
      3001
      8080
      8081
    ];

    dafos = {
      programs.terminal = {
        tools = {
          qmk.enable = cfg.keyboard.enable;
        };
      };

      virtualisation = {
        podman.enable = cfg.podman.enable;
      };
    };
  };
}
