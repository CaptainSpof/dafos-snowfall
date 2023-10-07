{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.suites.development;
  apps = {
    vscode = enabled;
  };
  cli-apps = {
    # TODO: add emacs
    neovim = enabled;
    prisma = enabled;
  };
in
{
  options.dafos.suites.development = with types; {
    enable = mkBoolOpt false
      "Whether or not to enable common development configuration.";
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
      inherit apps cli-apps;

      tools = {
        direnv = enabled;
        go = enabled;
        http = enabled;
        k8s = enabled;
        node = enabled;
        qmk = enabled;
      };

      virtualisation = { podman = enabled; };
    };
  };
}
