{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.services.remote-desktop;
in
{
  options.${namespace}.services.remote-desktop = {
    enable = mkBoolOpt false "Whether or not to configure remote-desktop support.";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 3389 ];

    environment.systemPackages = with pkgs; [
      kdePackages.krdc
      kdePackages.krfb
    ];
  };
}
