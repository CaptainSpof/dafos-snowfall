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
    mkIf cfg.enable {
      environment.sessionVariables.PATH = [ "$XDG_CONFIG_HOME/emacs/bin" ];
      environment.systemPackages = with pkgs; [ emacs ]; 
    };
}
