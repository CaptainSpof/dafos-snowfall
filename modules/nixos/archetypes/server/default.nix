{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.archetypes.server;
in
{
  options.dafos.archetypes.server = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable the server archetype.";
  };

  config = mkIf cfg.enable {
    dafos = {
      suites = {
        common-slim = enabled;
      };

      cli-apps = {
        neovim = enabled;
      };
    };
  };
}
