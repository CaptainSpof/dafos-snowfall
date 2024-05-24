{ lib, config, namespace, ... }:

let
  inherit (lib) types mkIf mkDefault mkMerge;
  inherit (lib.${namespace}) mkOpt;

  cfg = config.${namespace}.user;

  home-directory =
    if cfg.name == null then
      null
    else
      "/home/${cfg.name}";
in
{

  options.${namespace}.user = {
    enable = mkOpt types.bool false "Whether to configure the user account.";
    name = mkOpt (types.nullOr types.str) (config.snowfallorg.user.name or "daf") "The user account.";

    fullName = mkOpt types.str "Cédric Da Fonseca" "The full name of the user.";
    email = mkOpt types.str "dafonseca.cedric@gmail.com" "The email of the user.";
    gitEmail = mkOpt types.str "captain.spof@gmail.com" "The email of the user for git.";
    gitUsername = mkOpt types.str "CaptainSpof" "The username for git.";

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
