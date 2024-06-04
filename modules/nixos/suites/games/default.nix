{ config, lib, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.games;
  apps = {
    prismlauncher = enabled;
    steam = enabled;
  };
in
{
  options.${namespace}.suites.games = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common games configuration.";
  };

  config = mkIf cfg.enable { dafos = { inherit apps; }; };
}
