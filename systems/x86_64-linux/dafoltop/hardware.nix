{
  lib,
  modulesPath,
  inputs,
  pkgs,
  ...
}:

let
  inherit (inputs) nixos-hardware;
in
{
  imports = with nixos-hardware.nixosModules; [
    (modulesPath + "/installer/scan/not-detected.nix")
    common-cpu-intel
    common-pc
    common-pc-ssd
    common-pc-laptop
    common-pc-laptop-acpi_call
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [
      "tcp_bbr"
      "uhid"
    ];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
        "rtsx_pci_sdmmc"
        "uhid"
      ];
      kernelModules = [ "kvm-intel" ];
    };
    supportedFilesystems = [ "cifs" ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/0c5fdf84-5560-4d25-888b-1788147d0c2c";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/D0D5-28D9";
      fsType = "vfat";
    };

    "/home" = {
      device = "/dev/disk/by-uuid/d5455556-00a8-401b-8c06-294f431fa6ee";
      fsType = "ext4";
    };

    "/mnt/videos" = {
      device = "//192.168.0.254/Freebox/Vidéos";
      fsType = "cifs";
      options = [
        "guest"
        "noauto"
        "uid=1000"
        "vers=3"
        "nounix"
        "x-systemd.automount"
        "x-systemd.idle-timeout=60,x-systemd.device-timeout=15s,x-systemd.mount-timeout=15s"
      ];
    };
  };

  swapDevices = [ ];

  networking = {
    # Enable DHCP on the wireless link
    useDHCP = lib.mkDefault true;
    enableIPv6 = false;
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    graphics.enable = true;
    bluetooth.enable = true;
  };

  services.thermald.enable = true;

  powerManagement = {
    cpuFreqGovernor = lib.mkDefault "powersave";
    powertop.enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
