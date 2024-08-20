{
  config,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.programs.terminal.tools.direnv;
  fish = config.${namespace}.programs.terminal.shells.fish;
in
{
  options.${namespace}.programs.terminal.tools.direnv = {
    enable = mkBoolOpt false "Whether or not to enable direnv.";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv = enabled;
    };

    programs.fish = mkIf fish.enable {
      shellAbbrs = {
        da = "direnv allow";
      };
    };
  };
}
