{ lib, inputs, ... }:

with lib;
with lib.dafos;
let
  inherit (inputs) plasma-manager;
in
{
  imports = [
    ./hardware.nix
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  dafos = {
    archetypes = {
      workstation = enabled;
      gaming = enabled;
    };

    apps = {
      qbittorrent = enabled;
    };

    desktop = {
      plasma.touchScreen = true;
      plasma.bluetoothAdapter = "A4:F9:33:0E:06:BD";
    };

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
    };

    system = {
      kanata = enabled;
    };

    home.extraOptions = {
      imports = [ plasma-manager.homeManagerModules.plasma-manager ];

      programs.plasma = {
        configFile = {
          "kcminputrc"."Libinput.1739.52804.MSFT0001:00 06CB:CE44 Touchpad"."ClickMethod" = 2;
          "kcminputrc"."Libinput.1739.52804.MSFT0001:00 06CB:CE44 Touchpad"."Enabled" = true;
          "kcminputrc"."Libinput.1739.52804.MSFT0001:00 06CB:CE44 Touchpad"."NaturalScroll" = true;
          "kcminputrc"."Libinput.1739.52804.MSFT0001:00 06CB:CE44 Touchpad"."PointerAcceleration" = 0.45;
          "kcminputrc"."Libinput.1739.52804.MSFT0001:00 06CB:CE44 Touchpad"."PointerAccelerationProfile" = 1;
          "kcminputrc"."Libinput.1739.52804.MSFT0001:00 06CB:CE44 Touchpad"."TapToClick" = true;
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
