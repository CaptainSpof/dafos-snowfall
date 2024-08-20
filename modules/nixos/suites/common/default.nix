{ config, lib, pkgs, namespace, ... }:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled disabled;

  cfg = config.${namespace}.suites.common;
in
{
  options.${namespace}.suites.common = {
    enable = mkBoolOpt false "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      appimage-run
      cifs-utils
      dafos.list-iommu
      powertop
    ];

    dafos = {
      nix = enabled;

      programs = {
        terminal = {
          tools = {
            bandwhich = enabled;
            flake = enabled;
            nix-ld = enabled;
          };
        };
      };

      hardware = {
        audio = enabled;
        sensors = enabled;
        storage = enabled;
      };

      security = {
        doas = disabled;
        gpg = disabled;
        keyring.enable = config.${namespace}.desktop.gnome.enable;
      };

      services = {
        avahi = enabled;
        openssh = enabled;
        printing = enabled;
        remote-desktop = enabled;
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
    };
  };
}
