{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.plasma;
  home-directory = "/home/${config.${namespace}.user.name}";
  script-adapter-fix = pkgs.writeScript "bluedevil-force-adapter-status" ''
    #!/usr/bin/env bash
    echo 'bluedevil: forcing autostart for bluetooth adapter ${cfg.bluetoothAdapter}' | systemd-cat
    ${pkgs.gnused}/bin/sed -i 's/${cfg.bluetoothAdapter}_powered=false/${cfg.bluetoothAdapter}_powered=true/g' ${home-directory}/.config/bluedevilglobalrc
  '';


  defaultPackages = with pkgs.libsForQt5; [
    # Apps
    kate
    filelight
    # Scripts
    kwin-dynamic-workspaces
    kzones
    polonium
  ] ++ (with pkgs; [
    # Themes
    # dafos.abstractdark-sddm-theme
    dafos.kde-warm-eyes
    dafos.lightly-qt6
    gruvbox-gtk-theme
    kde-gruvbox
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
  imports = [
    ./config/plasma-config.nix
  ];

  options.${namespace}.desktop.plasma = with types; {
    enable =
      mkBoolOpt false "Whether or not to use Plasma as the desktop environment.";
    wayland = mkBoolOpt true "Whether or not to use Wayland.";
    touchScreen = mkBoolOpt false "Whether or not to enable touch screen capabilities.";
    bluetoothAdapter = mkOpt str "" "The bluetooth adapter ID";
    autoLoginUser = mkOpt str "" "The user to auto login with.";
    extensions = mkOpt (listOf package) [ ] "Extra Plasma extensions to install.";
  };

  config = mkIf cfg.enable {
    dafos.system.xkb.enable = true;
    dafos.desktop.addons = {
      electron-support = enabled;
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

      displayManager = {
        defaultSession = mkIf cfg.wayland "plasma";
        autoLogin = lib.optionalAttrs (cfg.autoLoginUser != "") {
          enable = true;
          user = cfg.autoLoginUser;
        };
      };

      libinput.enable = true;
      desktopManager.plasma6.enable = true;
    };

    programs.dconf.enable = true;
    programs.kdeconnect.enable = true;

    # Open firewall for samba connections to work.
    networking.firewall.extraCommands =
      "iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns";

    dafos.home.extraOptions = {
      systemd.user.services.bluedevil-adapter-fix = lib.optionalAttrs (cfg.bluetoothAdapter != "") {
        Unit.Description = "Force adapter powered status";
        Unit.After = [ "bluetooth.target" ];
        Install.WantedBy = [ "default.target" ];

        Service.Type = "oneshot";
        Service.ExecStart = "/bin/sh ${script-adapter-fix}";
      };
    };
  };
}
