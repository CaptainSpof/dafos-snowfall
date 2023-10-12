{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.cli-apps.tealdeer;
in
{
  options.dafos.cli-apps.tealdeer = with types; {
    enable = mkBoolOpt false "Whether or not to enable Tealdeer.";
  };

  config = mkIf cfg.enable {
    dafos.home.extraOptions = {
      programs.tealdeer = {
        enable = true;
        settings = {
          auto_update = true;
          directories.custom_pages_dir = ./pages;
        };
      };
    };
  };
}
