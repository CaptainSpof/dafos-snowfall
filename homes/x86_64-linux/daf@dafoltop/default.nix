{ lib, config, ... }:

with lib.dafos;
{
  dafos = {
    user = {
      enable = true;
      name = config.snowfallorg.user.name;
    };

    cli-apps = {
      zsh = enabled;
      neovim = enabled;
      home-manager = enabled;
    };

    tools = {
      git = enabled;
      direnv = enabled;
    };
  };
}
