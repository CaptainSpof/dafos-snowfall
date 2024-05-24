{ config, lib, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.cli-apps.zsh;
in
{
  options.${namespace}.cli-apps.zsh = with types; {
    enable = mkBoolOpt false "Whether or not to enable Zsh.";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      histFile = "$XDG_CACHE_HOME/zsh.history";
    };
  };
}
