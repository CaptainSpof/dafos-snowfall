{ lib, modulesPath, inputs, pkgs, ... }:

let inherit (inputs) nixos-hardware;
in {
  imports = with nixos-hardware.nixosModules; [
    (modulesPath + "/installer/scan/not-detected.nix")
    common-cpu-amd
    common-cpu-amd-pstate
    common-gpu-amd
    common-pc
    common-pc-ssd
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    binfmt.emulatedSystems = [ "aarch64-linux" ];
    initrd = {
      availableKernelModules =
        [ "xhci_pci" "thunderbolt" "nvme" "uas" "usb_storage" "sd_mod" ];
    };
    kernelModules = [ "tcp_bbr" "kvm-amd" "uhid" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/home" = {
      device = "/dev/disk/by-label/home";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
    "/mnt/videos" = {
      depends = [ "/" ];
      device = "//192.168.0.254/Freebox/Vidéos";
      fsType = "cifs";
      options = [
        "guest"
        "noauto"
        "uid=1000"
        "vers=1.0"
        "nounix"
        "x-systemd.automount"
        "x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s"
      ];
    };
  };

  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.eno1.wakeOnLan.enable = true;

  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
