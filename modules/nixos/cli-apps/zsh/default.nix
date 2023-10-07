{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.cli-apps.zsh;
in
{
  options.dafos.cli-apps.zsh = with types; {
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
