{ lib, config, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.dafos.cli-apps.fish;
  starship = config.dafos.cli-apps.starship;
in
{
  options.dafos.cli-apps.fish = {
    enable = mkEnableOption "Fish";
  };

  config = mkIf cfg.enable {
    programs = {
      fish = {
        enable = true;

        shellInit = mkIf starship.enable ''
          starship init fish | source
        '';

        functions = {
          fish_greeting = ''
            ${pkgs.toilet}/bin/toilet -f future --gay "Dafos"
          '';
          rm = "${pkgs.trash-cli}/bin/trash $argv";
          fwifi = {
            body = "nmcli -t -f SSID device wifi list | grep . | sk | xargs -o -I_ nmcli --ask dev wifi connect '_'";
            description = "Fuzzy connect to a wifi";
          };
        };
        plugins = [
          {
            name = "done";
            src = pkgs.fishPlugins.done;
          }
          {
            name = "puffer-fish";
            src = pkgs.fishPlugins.puffer;
          }
          {
            name = "pisces";
            src = pkgs.fishPlugins.pisces;
          }
          {
            name = "fzf.fish";
            src = pkgs.fetchFromGitHub {
              owner = "PatrickF1";
              repo = "fzf.fish";
              rev = "63c8f8e65761295da51029c5b6c9e601571837a1";
              sha256 = "sha256-i9FcuQdmNlJnMWQp7myF3N0tMD/2I0CaMs/PlD8o1gw=";
            };
          }
          {
            name = "colored-man-pages";
            src = pkgs.fishPlugins.colored-man-pages;
          }
          {
            name = "async-prompt";
            src = pkgs.fishPlugins.async-prompt.src;
          }
        ];
      };
    };
  };
}
