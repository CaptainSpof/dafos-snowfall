{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.desktop.plasma;

  defaultPackages = with pkgs.libsForQt5; [
    # Apps
    kate
    # Scripts
    kwin-dynamic-workspaces
    kzones
  ] ++ (with pkgs; [
    # Themes
    dafos.abstractdark-sddm-theme
    dafos.kde-warm-eyes
    gruvbox-gtk-theme
    kde-gruvbox
    lightly-boehs
    papirus-nord
    # Widgets & Plasmoids
    applet-window-buttons
    dafos.kde-controlcentre
    dafos.kde-minimalistclock
    dafos.plasma-applet-net-bandwidth-monitor
    dafos.simple-overview-pager
    dafos.thermalmonitor
  ]);
in
{
  imports = [ ./config/plasma-config.nix ];

  options.dafos.desktop.plasma = with types; {
    enable =
      mkBoolOpt false "Whether or not to use Plasma as the desktop environment.";
    wayland = mkBoolOpt true "Whether or not to use Wayland.";
    touchScreen = mkBoolOpt false "Whether or not to enable touch screen capabilities.";
    extensions = mkOpt (listOf package) [ ] "Extra Plasma extensions to install.";
  };

  config = mkIf cfg.enable {
    dafos.system.xkb.enable = true;
    dafos.desktop.addons = {
      electron-support = enabled;
      foot = enabled;
    };


    environment.systemPackages = with pkgs; [
      (hiPrio dafos.xdg-open-with-portal)
      wl-clipboard
    ] ++ (lib.optionals cfg.touchScreen [
      # Virtual keyboard
      maliit-framework
      maliit-keyboard
    ]) ++ defaultPackages ++ cfg.extensions;

    # environment.plasma.excludePackages = [ ];

    services.xserver = {
      enable = true;

      libinput.enable = true;
      displayManager.defaultSession = mkIf cfg.wayland "plasmawayland";
      displayManager.sddm = {
        enable = true;
        wayland.enable = cfg.wayland;
        theme = "abstractdark-sddm-theme";
      };
      desktopManager.plasma5.enable = true;
      desktopManager.plasma5.phononBackend = "vlc";
      desktopManager.plasma5.useQtScaling = true;
      desktopManager.plasma5.runUsingSystemd = true;
    };

    programs.dconf.enable = true;
    programs.kdeconnect.enable = true;

    # Open firewall for samba connections to work.
    networking.firewall.extraCommands =
      "iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns";
  };
}
