{
  lib,
  config,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;
  inherit (config.${namespace}.programs.terminal.shells) nushell fish zsh;

  cfg = config.${namespace}.programs.terminal.tools.zoxide;
in
{
  options.${namespace}.programs.terminal.tools.zoxide = {
    enable = mkBoolOpt false "Whether or not to enable zoxide.";
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
