{ config, lib, pkgs, ... }:

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
    dockerEnable =
      mkBoolOpt false
        "Whether or not to enable docker development configuration.";
    goEnable =
      mkBoolOpt false
        "Whether or not to enable go development configuration.";
    keyboardEnable =
      mkBoolOpt false
        "Whether or not to enable keyboard development configuration.";
    kubernetesEnable =
      mkBoolOpt false
        "Whether or not to enable kubernetes development configuration.";
    nixEnable =
      mkBoolOpt true
        "Whether or not to enable nix development configuration.";
    nodeEnable =
      mkBoolOpt false
        "Whether or not to enable nodejs development configuration.";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [
      12345
      3000
      3001
      8080
      8081
    ];

    environment.systemPackages = with pkgs; [
      tokei # need to know how many lines of poorly written code you typed ? 🦀
    ] ++ lib.optionals cfg.nixEnable [
    ];


    dafos = {

      tools = {
        direnv = enabled;
        http = enabled;
        k8s.enable = cfg.kubernetesEnable;
        qmk.enable = cfg.keyboardEnable;
        lang = {
          go.enable = cfg.goEnable;
          nix.enable = cfg.nixEnable;
          node.enable = cfg.nodeEnable;
        };
      };

      virtualisation = {
        podman.enable = cfg.dockerEnable;
      };
    };
  };
}
