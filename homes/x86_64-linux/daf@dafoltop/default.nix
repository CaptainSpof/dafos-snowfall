{ lib, config, ... }:

let
  inherit (lib.dafos) enabled;
in
{
  dafos = {
    user = {
      enable = true;
      name = config.snowfallorg.user.name;
    };

    cli-apps = {
      zsh = enabled;
      neovim = enabled;
      helix = enabled;
      home-manager = enabled;
    };

    tools = {
      git = enabled;
      direnv = enabled;
    };
  };
}
