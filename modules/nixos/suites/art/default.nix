{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.suites.art;
in
{
  options.dafos.suites.art = with types; {
    enable = mkBoolOpt false "Whether or not to enable art configuration.";
    drawing.enable = mkBoolOpt true "Whether or not to enable art drawing configuration.";
    vector.enable = mkBoolOpt false "Whether or not to enable art vector configuration.";
    graphics3d.enable = mkBoolOpt false "Whether or not to enable art graphics 3D configuration.";
    raster.enable = mkBoolOpt false "Whether or not to enable art raster configuration.";
  };

  config = mkIf cfg.enable {
    dafos = {
      apps = {
        krita.enable = cfg.drawing.enable;
        gimp.enable = cfg.raster.enable;
        inkscape.enable = cfg.vector.enable;
        blender.enable = cfg.graphics3d.enable;
      };
    };
  };
}
