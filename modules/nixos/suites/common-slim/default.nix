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

      apps = {
        alacritty = enabled;
      };

      cli-apps = {
        fish = enabled;
        flake = enabled;
        nushell = enabled;
        tealdeer = enabled;
      };

      hardware = {
        networking = enabled;
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
        time = enabled;
        xkb = enabled;
      };

      tools = {
        bat = enabled;
        bottom = enabled;
        comma = enabled;
        direnv = enabled;
        fup-repl = enabled;
        git = enabled;
        http = enabled;
      };
    };
  };
}
