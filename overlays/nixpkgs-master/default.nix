{ channels, ... }:

_final: _prev:

{
  inherit (channels.nixpkgs-master)
    home-assistant
    tandoor-recipes
    ;
}
