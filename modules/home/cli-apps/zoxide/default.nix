{ lib, config, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.cli-apps.zoxide;
  nushell = config.${namespace}.cli-apps.nushell;
  fish = config.${namespace}.cli-apps.fish;
  zsh = config.${namespace}.cli-apps.zsh;
in
{
  options.${namespace}.cli-apps.zoxide = {
    enable = mkEnableOption "Zoxide";
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
