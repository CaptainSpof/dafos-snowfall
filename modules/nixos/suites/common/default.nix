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
      pkgs.dafos.run-me
    ];

    dafos = {
      nix = enabled;

      apps = {
        alacritty = enabled;
        kitty = enabled;
      };

      cli-apps = {
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
        storage = enabled;
      };

      security = {
        doas = disabled;
        gpg = disabled;
        keyring = enabled;
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
