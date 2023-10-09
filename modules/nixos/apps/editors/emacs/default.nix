{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.apps.emacs;
in
{
  options.dafos.apps.emacs = with types; {
    enable = mkBoolOpt false "Whether or not to enable Emacs.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ emacs ]; };
}
