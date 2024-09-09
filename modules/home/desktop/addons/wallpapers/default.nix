{
  pkgs,
  lib,
  namespace,
  ...
}:

let
  inherit (lib.${namespace}) mkBoolOpt;
  inherit (pkgs.dafos) wallpapers;
in
{
  options.${namespace}.desktop.addons.wallpapers = {
    enable = mkBoolOpt false "Whether or not to add wallpapers to ~/Pictures/wallpapers.";
  };

  config = {
    home.file = lib.foldl (
      acc: name:
      let
        wallpaper = wallpapers.${name};
      in
      acc // { "Pictures/wallpapers/${wallpaper.fileName}".source = wallpaper; }
    ) { } wallpapers.names;
  };
}
