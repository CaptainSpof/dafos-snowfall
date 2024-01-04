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
      emacs = enabled;
      firefox = {
        gpuAcceleration = true;
        hardwareDecoding = true;
        settings = {
          # "dom.ipc.processCount.webIsolated" = 9;
          # "dom.maxHardwareConcurrency" = 16;
          "media.av1.enabled" = false;
          # "media.ffvpx.enabled" = false;
          # "media.hardware-video-decoding.force-enabled" = true;
          "media.hardwaremediakeys.enabled" = true;
        };
      };
    };

    cli-apps = {
      fish = enabled;
      helix = enabled;
      home-manager = enabled;
      neovim = enabled;
      nushell = enabled;
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
