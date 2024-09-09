{
  lib,
  config,
  namespace,
  ...
}:

let
  inherit (lib.${namespace}) enabled;
in
{
  dafos = {
    user = {
      enable = true;
      inherit (config.snowfallorg.user) name;
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
      video = enabled;
    };
  };
}
