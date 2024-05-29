{ config , lib , namespace, ...}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli-apps.lazygit;
in
{
  options.${namespace}.cli-apps.lazygit = {
    enable = mkBoolOpt false "Whether or not to enable lazygit.";
  };

  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
    };

    home.shellAliases = {
      lg = "lazygit";
    };
  };
}
