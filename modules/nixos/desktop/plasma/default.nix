{ inputs, config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.plasma;

  defaultPackages = (with pkgs; [
    # Themes
    dafos.kde-warm-eyes
    dafos.lightly-qt6
    gruvbox-gtk-theme
    kde-gruvbox
    papirus-nord
    # Widgets & Plasmoids
  ]);
in
{
  options.${namespace}.desktop.plasma = with types; {
    enable =
      mkBoolOpt false "Whether or not to use Plasma as the desktop environment.";
    wayland = mkBoolOpt true "Whether or not to use Wayland.";
    touchScreen = mkBoolOpt false "Whether or not to enable touch screen capabilities.";
    autoLoginUser = mkOpt str "" "The user to auto login with.";
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
    ]) ++ defaultPackages;

    services = {
      desktopManager.plasma6.enable = true;

      displayManager = {
        defaultSession = mkIf cfg.wayland "plasma";
        autoLogin = lib.optionalAttrs (cfg.autoLoginUser != "") {
          enable = true;
          user = cfg.autoLoginUser;
        };
      };

      libinput.enable = true;
      xserver.enable = true;
    };

    programs.dconf.enable = true;
    programs.kdeconnect.enable = true;

    # Open firewall for samba connections to work.
    networking.firewall.extraCommands =
      "iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns";

    dafos.home.extraOptions = {
      imports = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
    };
  };
}
