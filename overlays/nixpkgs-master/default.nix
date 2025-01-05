{ channels, ... }:

_final: _prev:

{
  inherit (channels.nixpkgs-master)
    cnijfilter2
    home-assistant
    rocmPackages_6
    tandoor-recipes
    wezterm
    xdg-desktop-portal
    ;
}
