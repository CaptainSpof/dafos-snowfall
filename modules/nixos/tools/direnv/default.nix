{ config, lib, namespace, ... }:

with lib;
with lib.${namespace};
let cfg = config.${namespace}.tools.direnv;
in
{
  options.${namespace}.tools.direnv = with types; {
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
