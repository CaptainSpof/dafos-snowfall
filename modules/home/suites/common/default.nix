{ config, lib, namespace, pkgs, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.suites.common;
in
{
  options.${namespace}.suites.common = {
    enable = mkBoolOpt false "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      coreutils
      curl
      duf
      fd
      file
      findutils
      fzf
      jq
      killall
      lsof
      pciutils
      procs
      unrar
      unzip
      wget
      xclip
    ];

    dafos = {
      programs = {
        graphical = {
          browsers = {
            firefox = enabled;
          };
        };

        terminal = {
          emulators = {
            alacritty = enabled;
            kitty = enabled;
          };

          shells = {
            fish = enabled;
            nushell = enabled;
            zsh = enabled;
          };

          tools = {
            bat = enabled;
            bottom = enabled;
            comma = enabled;
            direnv = enabled;
            eza = enabled;
            fup-repl = enabled;
            git = enabled;
            home-manager = enabled;
            less = enabled;
            ripgrep = enabled;
            starship = enabled;
            zellij = enabled;
            zoxide = enabled;
          };
        };
      };
      services = {
        espanso = enabled;
      };
    };

    programs.readline = {
      enable = true;

      extraConfig = ''
        set completion-ignore-case on
      '';
    };

    xdg.configFile.wgetrc.text = "";
  };
}
