{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.desktop.plasma;

  defaultExtensions = with pkgs.libsForQt5; [
    # Scripts
    kwin-dynamic-workspaces
    kzones
    # Widgets & Plasmoids
    applet-window-buttons
    pkgs.dafos.kde-controlcentre
    pkgs.dafos.kde-minimalistclock
    pkgs.dafos.simple-overview-pager
    pkgs.dafos.plasma-applet-net-bandwidth-monitor
  ];
in
{
  imports = [ ./config/plasma-config.nix ];

  options.dafos.desktop.plasma = with types; {
    enable =
      mkBoolOpt false "Whether or not to use Plasma as the desktop environment.";
    wallpaper = {
      light = mkOpt (oneOf [ str package ]) pkgs.dafos.wallpapers.nord-rainbow-light-nix "The light wallpaper to use.";
      dark = mkOpt (oneOf [ str package ]) pkgs.dafos.wallpapers.nord-rainbow-dark-nix "The dark wallpaper to use.";
    };
    color-scheme = mkOpt (enum [ "light" "dark" ]) "dark" "The color scheme to use.";
    wayland = mkBoolOpt true "Whether or not to use Wayland.";
    touchScreen = mkBoolOpt false "Whether or not to use Wayland.";
    extensions = mkOpt (listOf package) [ ] "Extra Plasma extensions to install.";
  };

  config = mkIf cfg.enable {
    dafos.system.xkb.enable = true;
    dafos.desktop.addons = {
      wallpapers = disabled;
      electron-support = enabled;
      foot = enabled;
    };

    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      (hiPrio dafos.xdg-open-with-portal)
      wl-clipboard

      # Themes
      dafos.kde-warm-eyes
      gruvbox-gtk-theme
      kde-gruvbox
      lightly-boehs
      papirus-nord
    ] ++ lib.optional (cfg.touchScreen) [
      # Virtual keyboard
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

    programs.kdeconnect = {
      enable = true;
    };

    # Open firewall for samba connections to work.
    networking.firewall.extraCommands =
      "iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns";
  };
}
