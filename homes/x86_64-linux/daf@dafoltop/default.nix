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
      fish = enabled;
      starship = enabled;
      helix = enabled;
      home-manager = enabled;
      neovim = enabled;
      zellij = enabled;
      zsh = enabled;
    };

    tools = {
      git = enabled;
      direnv = enabled;
    };
  };
}
