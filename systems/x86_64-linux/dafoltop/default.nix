{ config, inputs, lib, namespace, ... }:

with lib;
with lib.${namespace};
let
  inherit (inputs) plasma-manager;
in
{
  imports = [
    ./hardware.nix
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # disable sleep
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  dafos = {
    archetypes = {
      workstation = enabled;
    };

    apps = {
      qbittorrent = enabled;
    };

    desktop.plasma.autoLoginUser = config.${namespace}.user.name;

    security = {
      gpg = mkForce disabled;
    };

    services = {
      home-assistant = enabled;
      mealie = enabled;
    };

    suites = {
      art = mkForce disabled;
      desktop = enabled;
      social = mkForce disabled;
      video = {
        enable = true;
      };
      yahrr = enabled;
    };

    system = {
      kanata = enabled;
    };

    home.extraOptions = {
      imports = [ plasma-manager.homeManagerModules.plasma-manager ];

      programs.plasma = {
        configFile = {
          # disable screensaver
          # "kscreenlockerrc"."Daemon"."Autolock" = false;
          # "kscreenlockerrc"."Daemon"."LockOnResume" = false;
          # touchpad settings
          # "kcminputrc"."Libinput.1267.12419.ETD2303:00 04F3:3083 Touchpad"."NaturalScroll" = true;
          # "kcminputrc"."Libinput.1267.12419.ETD2303:00 04F3:3083 Touchpad"."PointerAccelerationProfile" = 1;
          # "kcminputrc"."Libinput.1267.12419.ETD2303:00 04F3:3083 Touchpad"."TapToClick" = true;
        };
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Can't touch this 🔨
}
