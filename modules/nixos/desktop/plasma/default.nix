{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.desktop.plasma;

  defaultExtensions = [ ];
in
{
  imports = [ ./plasma-conf.nix ];

  options.dafos.desktop.plasma = with types; {
    enable =
      mkBoolOpt false "Whether or not to use Plasma as the desktop environment.";
    wallpaper = {
      light = mkOpt (oneOf [ str package ]) pkgs.dafos.wallpapers.nord-rainbow-light-nix "The light wallpaper to use.";
      dark = mkOpt (oneOf [ str package ]) pkgs.dafos.wallpapers.nord-rainbow-dark-nix "The dark wallpaper to use.";
    };
    color-scheme = mkOpt (enum [ "light" "dark" ]) "dark" "The color scheme to use.";
    wayland = mkBoolOpt true "Whether or not to use Wayland.";
    extensions = mkOpt (listOf package) [ ] "Extra Plasma extensions to install.";
  };

  config = mkIf cfg.enable {
    dafos.system.xkb.enable = true;
    dafos.desktop.addons = {
      gtk = enabled;
      wallpapers = enabled;
      electron-support = enabled;
      foot = enabled;
    };

    environment.systemPackages = with pkgs; [
      (hiPrio dafos.xdg-open-with-portal)
      wl-clipboard

      # virtual keyboard
      maliit-framework
      maliit-keyboard
    ] ++ defaultExtensions ++ cfg.extensions;

    # environment.plasma.excludePackages = [ ];

    services.xserver = {
      enable = true;

      libinput.enable = true;
      displayManager.defaultSession = mkIf cfg.wayland "plasmawayland";
      displayManager.sddm = {
        enable = true;
        wayland.enable = cfg.wayland;
      };
      desktopManager.plasma5.enable = true;
      desktopManager.plasma5.useQtScaling = true;
      desktopManager.plasma5.runUsingSystemd = true;
    };

    # dafos.home.extraOptions = {

    # };

    programs.kdeconnect = {
      enable = true;
    };

    # Open firewall for samba connections to work.
    networking.firewall.extraCommands =
      "iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns";
  };
}
