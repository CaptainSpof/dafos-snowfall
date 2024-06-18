{ lib, config, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.programs.terminal.tools.zoxide;
  nushell = config.${namespace}.programs.terminal.shells.nushell;
  fish = config.${namespace}.programs.terminal.shells.fish;
  zsh = config.${namespace}.programs.terminal.shells.zsh;
in
{
  options.${namespace}.programs.terminal.tools.zoxide = {
    enable = mkEnableOption "Whether or not to enable zoxide.";
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;

      enableFishIntegration = fish.enable;
      enableNushellIntegration = nushell.enable;
      enableZshIntegration = zsh.enable;

      options = [ "--cmd=c" ];
    };
  };
}
