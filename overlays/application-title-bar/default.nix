{ channels, ... }:

_final: prev:

{
  inherit (channels.nixpkgs-master) application-title-bar;
}
