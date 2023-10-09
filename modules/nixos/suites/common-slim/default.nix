{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.suites.common-slim;
in
{
  options.dafos.suites.common-slim = with types; {
    enable = mkBoolOpt false "Whether or not to enable common-slim configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.dafos.list-iommu
    ];

    dafos = {
      nix = enabled;

      apps = {
        alacritty = enabled;
      };

      cli-apps = {
        flake = enabled;
        fish = enabled;
      };

      hardware = {
        storage = enabled;
        networking = enabled;
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
