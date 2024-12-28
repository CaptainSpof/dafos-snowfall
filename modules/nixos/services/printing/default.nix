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

  cfg = config.${namespace}.services.printing;
  patchedCnijfilter2 = pkgs.cnijfilter2.overrideAttrs (oldAttrs: {
    patches = oldAttrs.patches ++ [ ./cnijfilter2.patch ];
  });
in
{
  options.${namespace}.services.printing = {
    enable = mkBoolOpt false "Whether or not to configure printing support.";
  };

  config = mkIf cfg.enable {
    services.printing = {
      enable = true;
      browsing = true;

      drivers = [
        patchedCnijfilter2
      ];
    };

    environment.systemPackages = with pkgs; [ skanpage ];
  };
}
