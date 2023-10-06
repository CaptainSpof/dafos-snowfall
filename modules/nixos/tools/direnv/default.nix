{ config, lib, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.tools.direnv;
in
{
  options.dafos.tools.direnv = with types; {
    enable = mkBoolOpt false "Whether or not to enable direnv.";
  };

  config = mkIf cfg.enable {
    dafos.home.extraOptions = {
      programs.direnv = {
        enable = true;
        nix-direnv = enabled;
      };
    };
  };
}
