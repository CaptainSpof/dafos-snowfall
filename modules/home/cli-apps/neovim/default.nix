{ lib, config, pkgs, namespace, ... }:

let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.cli-apps.neovim;
in
{
  options.${namespace}.cli-apps.neovim = {
    enable = mkEnableOption "Whether or not to enable Neovim";
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        less
        neovim
      ];

      sessionVariables = {
        PAGER = "less";
        MANPAGER = "less";
        NPM_CONFIG_PREFIX = "$HOME/.npm-global";
        EDITOR = "nvim";
      };

      shellAliases = {
        vimdiff = "nvim -d";
        vim = "nvim";
      };
    };

    xdg.configFile = {
      "dashboard-nvim/.keep".text = "";
    };
  };
}
