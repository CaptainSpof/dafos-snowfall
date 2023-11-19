{ config, inputs, lib, ... }:

with lib;
with lib.dafos;
let
  inherit (inputs) plasma-manager;
  vars = config.dafos.vars;
in
{
  imports = [
    ./hardware.nix
    ../../../modules/vars.nix
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  dafos = {
    archetypes = {
      workstation = enabled;
    };

    apps = {
      qbittorrent = enabled;
    };

    desktop.plasma.autoLoginUser = vars.username;

    security = {
      gpg = mkForce disabled;
    };

    suites = {
      desktop = enabled;
      office = enabled;
      development = enabled;
      video = {
        enable = true;
        recording = enabled;
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
          "kscreenlockerrc"."Daemon"."Autolock" = false;
          "kscreenlockerrc"."Daemon"."LockOnResume" = false;
          # touchpad settings
          "kcminputrc"."Libinput.1267.12419.ETD2303:00 04F3:3083 Touchpad"."NaturalScroll" = true;
          "kcminputrc"."Libinput.1267.12419.ETD2303:00 04F3:3083 Touchpad"."PointerAccelerationProfile" = 1;
          "kcminputrc"."Libinput.1267.12419.ETD2303:00 04F3:3083 Touchpad"."TapToClick" = true;
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
