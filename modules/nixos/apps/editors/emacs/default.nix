{ options, config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let cfg = config.${namespace}.apps.emacs;
in
{
  options.${namespace}.apps.emacs = with types; {
    enable = mkBoolOpt false "Whether or not to enable Emacs.";
  };

  config =
    mkIf cfg.enable {
      environment.sessionVariables.PATH = [ "$XDG_CONFIG_HOME/emacs/bin" ];
      environment.systemPackages = with pkgs; [ emacs ]; 
    };
}
