{ lib, config, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.cli-apps.zoxide;
  nushell = config.dafos.cli-apps.nushell;
  fish = config.dafos.cli-apps.fish;
  zsh = config.dafos.cli-apps.zsh;
in
{
  options.dafos.cli-apps.zoxide = {
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
