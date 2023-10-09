{ lib, config, pkgs, ... }:

let
  inherit (lib) mkIf types;
  inherit (lib.dafos) mkOpt mkBoolOpt;

  cfg = config.dafos.apps.emacs;
in
{
  options.dafos.apps.emacs = {
    enable = mkBoolOpt false "Whether or not to enable Emacs";
    package = mkOpt types.package pkgs.emacs29-pgtk "The Emacs package to be used.";
  };

  config = mkIf cfg.enable {

    services.emacs = {
      enable = true;
      inherit (cfg) package;
    };

    programs.emacs = {
      enable = true;
      inherit (cfg) package;
      extraPackages = (epkgs: with epkgs; [ vterm pdf-tools sqlite ]);
    };

    home.packages = with pkgs; [
      djvu2pdf
      gcc
      sqlite
      cmake
      texlive.combined.scheme-full
      (aspellWithDicts (ds: with ds; [ en en-computers en-science fr ]))
    ];
  };
}
