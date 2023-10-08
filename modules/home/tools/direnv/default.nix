{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.tools.direnv;
  fish = config.dafos.cli-apps.fish;
in
{
  options.dafos.tools.direnv = with types; {
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
