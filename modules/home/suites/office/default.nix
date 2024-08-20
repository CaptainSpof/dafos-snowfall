{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.suites.office;
in
{
  options.${namespace}.suites.office = {
    enable = mkBoolOpt false "Whether or not to enable office configuration.";
    onlyoffice.enable = mkBoolOpt false "Whether or not to enable onlyoffice configuration.";
  };

  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        libreoffice
        rnote
      ]
      ++ lib.optionals cfg.onlyoffice.enable [ onlyoffice-bin ];
  };
}
