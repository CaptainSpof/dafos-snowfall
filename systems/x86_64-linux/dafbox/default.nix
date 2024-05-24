{ config, lib, namespace, ... }:

with lib;
with lib.${namespace};
let username = config.${namespace}.user.name;
in {
  imports = [ ./hardware.nix ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  services.xserver.videoDrivers = mkDefault [ "amdgpu" ];

  dafos = {
    archetypes = {
      workstation = enabled;
      gaming = enabled;
    };

    apps = { qbittorrent = enabled; };

    desktop = {
      plasma.bluetoothAdapter = "74:97:79:D8:5B:D2";
      plasma.autoLoginUser = username;
    };

    security = { gpg = mkForce disabled; };

    suites = {
      desktop = enabled;
      development = { enable = true; };
      office = enabled;
      video = {
        enable = true;
        recording = enabled;
      };
    };

    system = { kanata = enabled; };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Can't touch this 🔨
}
