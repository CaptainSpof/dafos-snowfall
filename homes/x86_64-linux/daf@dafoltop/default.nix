{ lib, config, namespace, ... }:

let
  inherit (lib.${namespace}) enabled;
in
{
  dafos = {
    user = {
      enable = true;
      name = config.${namespace}.user.name;
    };

    apps = {
      alacritty = enabled;
      emacs = enabled;
    };

    cli-apps = {
      fish = enabled;
      helix = enabled;
      home-manager = enabled;
      lazygit = enabled;
      neovim = enabled;
      nushell = enabled;
      starship = enabled;
      zellij = enabled;
      zoxide = enabled;
      zsh = enabled;
    };

    tools = {
      git = enabled;
      direnv = enabled;
    };
  };
}
