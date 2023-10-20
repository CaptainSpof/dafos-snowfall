{ channels, ... }:

final: _prev:

{
  inherit (channels.nixpkgs-master) fzf;
}
