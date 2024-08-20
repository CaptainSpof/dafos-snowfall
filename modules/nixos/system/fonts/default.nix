{
  config,
  pkgs,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkOpt mkBoolOpt;

  cfg = config.${namespace}.system.fonts;
in
{
  options.${namespace}.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [ ] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      # Enable icons in tooling since we have nerdfonts.
      LOG_ICONS = "true";
    };

    fonts.packages =
      with pkgs;
      [
        (nerdfonts.override {
          fonts = [
            "CascadiaCode"
            "Hack"
            "Monaspace"
            "NerdFontsSymbolsOnly"
          ];
        })
        google-fonts
        iosevka-comfy.comfy
        iosevka-comfy.comfy-duo
        iosevka-comfy.comfy-fixed
        iosevka-comfy.comfy-motion
        iosevka-comfy.comfy-motion-duo
        iosevka-comfy.comfy-motion-fixed
        iosevka-comfy.comfy-wide
        iosevka-comfy.comfy-wide-duo
        iosevka-comfy.comfy-wide-fixed
        iosevka-comfy.comfy-wide-motion-duo
        iosevka-comfy.comfy-wide-motion-fixed
        julia-mono
        maple-mono
        maple-mono-NF
        merriweather
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        noto-fonts-emoji
        roboto
        roboto-mono
        sarasa-gothic
        twemoji-color-font
      ]
      ++ cfg.fonts;
  };
}
