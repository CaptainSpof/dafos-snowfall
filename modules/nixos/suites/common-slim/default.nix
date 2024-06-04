{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.common-slim;
in
{
  options.${namespace}.suites.common-slim = with types; {
    enable = mkBoolOpt false "Whether or not to enable common-slim configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      cifs-utils
      pkgs.dafos.list-iommu
      powertop
    ];

    dafos = {
      nix = enabled;

      programs.terminal.tools = {
        flake = enabled;
      };

      hardware = {
        storage = enabled;
      };

      security = {
        doas = disabled;
      };

      services = {
        avahi = enabled;
        openssh = enabled;
        tailscale = enabled;
      };

      system = {
        boot = enabled;
        fonts = enabled;
        locale = enabled;
        networking = enabled;
        time = enabled;
        xkb = enabled;
      };

      tools = {
        comma = enabled;
        git = enabled;
      };
    };
  };
}
