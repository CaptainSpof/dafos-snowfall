{ config, lib, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.tools.direnv;
  fish = config.${namespace}.cli-apps.fish;
in
{
  options.${namespace}.tools.direnv = with types; {
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
