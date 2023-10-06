{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.apps.inkscape;
in
{
  options.dafos.apps.inkscape = with types; {
    enable = mkBoolOpt false "Whether or not to enable Inkscape.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ inkscape-with-extensions google-fonts ];
  };
}
