{ channels, ... }:

_final: prev:

{
  inherit (channels.nixpkgs-master) linuxPackages_latest;

  # Fixes an issue with building Raspberry Pi kernels:
  # https://github.com/NixOS/nixpkgs/issues/154163
  makeModulesClosure = x: prev.makeModulesClosure (x // {
    allowMissing = true;
  });
}
