{ lib, config, ... }:

let
  inherit (lib) mkIf;
  inherit (lib.dafos) mkBoolOpt;

  cfg = config.dafos.cli-apps.helix;
in
{
  options.dafos.cli-apps.helix = {
    enable = mkBoolOpt false "Whether or not to enable Helix";
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;

      settings = {
        theme = "everforest_dark";
        editor = {
          indent-guides.enable = true;
          
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
        };
      };
    };
  };
}
