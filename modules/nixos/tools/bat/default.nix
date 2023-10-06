{ config , lib , pkgs , ...}:

let
  inherit (lib) mkIf;
  inherit (lib.dafos) mkBoolOpt;

  cfg = config.dafos.tools.bat;
in
{
  options.dafos.tools.bat = {
    enable = mkBoolOpt false "Whether or not to enable bat.";
  };

  config = mkIf cfg.enable {
    dafos.home.extraOptions = {
      programs.bat = {
        enable = true;

        config = {
          theme = "gruvbox";
          style = "auto,header-filesize";
        };

        extraPackages = with pkgs.bat-extras; [
          batdiff
          batgrep
          batman
          batpipe
          batwatch
          prettybat
        ];
      };

      home.shellAliases = {
        cat = "bat";
      };
    };
  };
}
