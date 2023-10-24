{ lib, config, ... }:

let
  inherit (lib) types mkIf mkDefault mkMerge;
  inherit (lib.dafos) mkOpt;

  cfg = config.dafos.user;

  vars = config.dafos.vars;

  home-directory =
    if cfg.name == null then
      null
    else
      "/home/${cfg.name}";
in
{
  imports = [ ../../vars.nix ];

  options.dafos.user = {
    enable = mkOpt types.bool false "Whether to configure the user account.";
    name = mkOpt (types.nullOr types.str) vars.username "The user account.";

    fullName = mkOpt types.str vars.fullname "The full name of the user.";
    email = mkOpt types.str vars.email "The email of the user.";

    home = mkOpt (types.nullOr types.str) home-directory "The user's home directory.";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      assertions = [
        {
          assertion = cfg.name != null;
          message = "dafos.user.name must be set";
        }
        {
          assertion = cfg.home != null;
          message = "dafos.user.home must be set";
        }
      ];

      home = {
        username = mkDefault cfg.name;
        homeDirectory = mkDefault cfg.home;


        shellAliases = rec {
          # navigation
          "~~" = "cd $(git rev-parse --show-toplevel)";

          # nix
          n = "nix";
          ns = "nix search --no-update-lock-file nixpkgs";
          nf = "nix flake";
          nfu = "nix flake update";
          nepl = "nix repl '<nixpkgs>'";
          nr = ''nixos-rebuild --use-remote-sudo --flake "$(pwd)#$(hostname)"'';
          nR = "nix run nixpkgs#";
          nS = "nix shell nixpkgs#";
          nrb = "${nr} build";
          nrs = "${nr} switch";
          ncl = ''sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +10'';
          ngc = "nix store gc --debug";
          ndiff = "nix store diff-closures /nix/var/nix/profiles/(ls -r /nix/var/nix/profiles/ | grep -E 'system\-' | sed -n '2 p') /nix/var/nix/profiles/system";

          # rm
          rmf = "rm -rf";

          # systemd
          sys = "sudo systemctl";
          sysu = "systemctl --user";
          j = "journalctl";
          jb = "journalctl -b";
          ju = "journalctl -u";

          # misc
          q = "exit";
          mkdir = "mkdir -pv";
          y = "wl-copy";
          p = "wl-paste";
          pp = "pwd";
        };

      };
    }
  ]);
}
