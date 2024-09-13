{
  lib,
  config,
  namespace,
  ...
}:

let
  inherit (lib.${namespace}) enabled disabled;
in
{
  dafos = {
    user = {
      enable = true;
      inherit (config.snowfallorg.user) name;
    };

    desktop = {
      plasma = {
        screenlocker = disabled;
      };
    };

    programs = {
      terminal = {
        tools = {
          ssh = enabled;
        };
      };
    };

    suites = {
      common = enabled;
      desktop = enabled;
      video = enabled;
    };
  };
}
