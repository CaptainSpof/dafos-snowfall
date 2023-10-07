{ config , lib , ...}:

let
  inherit (lib) mkIf;
  inherit (lib.dafos) mkBoolOpt;

  cfg = config.dafos.cli-apps.lazygit;
in
{
  options.dafos.cli-apps.lazygit = {
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
