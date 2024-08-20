{
  config,
  lib,
  namespace,
  ...
}:

let
  inherit (lib)
    mapAttrs
    concatStringsSep
    mkOption
    types
    mapAttrsToList
    ;

  cfg = config.${namespace}.system.env;
in
{
  options.${namespace}.system.env =
    with types;
    mkOption {
      type = attrsOf (oneOf [
        str
        path
        (listOf (either str path))
      ]);
      apply = mapAttrs (
        _n: v: if isList v then concatMapStringsSep ":" (x: toString x) v else (toString v)
      );
      default = { };
      description = "A set of environment variables to set.";
    };

  config = {
    environment = {
      sessionVariables = {
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_BIN_HOME = "$HOME/.local/bin";
        # To prevent firefox from creating ~/Desktop.
        XDG_DESKTOP_DIR = "$HOME";
      };
      variables = {
        # Make some programs "XDG" compliant.
        LESSHISTFILE = "$XDG_CACHE_HOME/less.history";
        WGETRC = "$XDG_CONFIG_HOME/wgetrc";
      };
      extraInit = concatStringsSep "\n" (mapAttrsToList (n: v: ''export ${n}="${v}"'') cfg);
    };
  };
}
