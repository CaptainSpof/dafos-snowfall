{ config, lib, modulesPath, inputs, pkgs, ... }:

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
    kernelModules = [ "tcp_bbr" "uhid" ];

    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc" "uhid" ];
      kernelModules = [ "kvm-intel" ];
    };

    extraModulePackages = [ ];
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/0c5fdf84-5560-4d25-888b-1788147d0c2c";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D0D5-28D9";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/d5455556-00a8-401b-8c06-294f431fa6ee";
      fsType = "ext4";
    };

  swapDevices = [ ];

  # swapDevices = [{ device = "/dev/disk/by-label/swap"; }];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.opengl.enable = true;

  hardware.bluetooth.enable = true;

  # Enable DHCP on the wireless link
  networking = {
    useDHCP = lib.mkDefault true;
  };
}
