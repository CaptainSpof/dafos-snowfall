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

    apps = {
      alacritty = enabled;
    };

    cli-apps = {
      fish = enabled;
      helix = enabled;
      home-manager = enabled;
      neovim = enabled;
      starship = enabled;
      zellij = enabled;
      zoxide = enabled;
      zsh = enabled;
      lazygit = enabled;
    };

    tools = {
      git = enabled;
      direnv = enabled;
    };
  };
}
