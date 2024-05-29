{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.common;
in
{
  options.${namespace}.suites.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cifs-utils
      dafos.list-iommu
      powertop
    ];

    dafos = {
      nix = enabled;

      apps = {
        alacritty = enabled;
        kitty = enabled;
      };

      cli-apps = {
        bandwhich = enabled;
        eza = enabled;
        fish = enabled;
        flake = enabled;
        nushell = enabled;
        tealdeer = enabled;
        zsh = enabled;
      };

      hardware = {
        audio = enabled;
        networking = enabled;
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
        fup-repl = enabled;
        git = enabled;
        http = enabled;
        misc = enabled;
        nix-ld = enabled;
      };
    };
  };
}
