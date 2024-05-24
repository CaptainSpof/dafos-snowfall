{ config , lib , pkgs , namespace, ...}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.tools.bat;
in
{
  options.${namespace}.tools.bat = {
    enable = mkBoolOpt false "Whether or not to enable bat.";
  };

  config = mkIf cfg.enable {
    dafos.home.extraOptions = {
      programs.bat = {
        enable = true;

        config = {
          theme = "gruvbox-dark";
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
