{ lib, config, pkgs, ... }:

let
  inherit (lib) mkIf;
  inherit (lib.dafos) mkBoolOpt;

  cfg = config.dafos.cli-apps.emacs;
in
{
  options.dafos.cli-apps.emacs = {
    enable = mkBoolOpt false "Whether or not to enable Emacs";
  };

  config = mkIf cfg.enable {

    services.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
    };

    programs.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
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
