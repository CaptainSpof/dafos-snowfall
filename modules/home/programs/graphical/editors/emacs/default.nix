{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:

let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkOpt mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.editors.emacs;
in
{
  options.${namespace}.programs.graphical.editors.emacs = {
    enable = mkBoolOpt false "Whether or not to enable emacs.";
    latex.enable = mkBoolOpt false "Whether or not to enable latex support for emacs."; # TODO
    package = mkOpt types.package pkgs.emacs-pgtk "The emacs package to be used.";
  };

  config = mkIf cfg.enable {

    services.emacs = {
      enable = true;
      inherit (cfg) package;
    };

    programs.emacs = {
      enable = true;
      inherit (cfg) package;
      extraPackages = (
        epkgs: with epkgs; [
          vterm
          pdf-tools
          sqlite
          jinx
        ]
      );
    };

    xdg.desktopEntries.org-protocol = {
      name = "org-protocol";
      exec = "emacsclient -- %u";
      terminal = false;
      type = "Application";
      categories = [ "System" ];
      mimeType = [ "x-scheme-handler/org-protocol" ];
    };

    home = {
      packages = with pkgs; [
        enchant
        djvu2pdf
        sqlite
        # texlive.combined.scheme-full
        nuspell
        (aspellWithDicts (
          ds: with ds; [
            en
            en-computers
            en-science
            fr
          ]
        ))
        hunspellDicts.en-us
        hunspellDicts.fr-any
      ];

      sessionPath = [ "$XDG_CONFIG_HOME/emacs/bin" ];
      shellAliases = {
        "ne" = "emacsclient -nw";
      };
    };
  };
}
