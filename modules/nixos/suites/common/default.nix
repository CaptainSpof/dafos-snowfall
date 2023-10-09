{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.suites.common;
in
{
  options.dafos.suites.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.dafos.list-iommu
    ];

    dafos = {
      nix = enabled;

      apps = {
        alacritty = enabled;
        kitty = enabled;
      };

      cli-apps = {
        flake = enabled;
        fish = enabled;
        zsh = enabled;
        eza = enabled;
      };

      hardware = {
        audio = enabled;
        storage = enabled;
        networking = enabled;
      };

      security = {
        gpg = enabled;
        doas = disabled;
        keyring = enabled;
      };

      services = {
        avahi = enabled;
        printing = enabled;
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
        fup-repl = enabled;
        git = enabled;
        http = enabled;
        misc = enabled;
        nix-ld = enabled;
      };
    };
  };
}
