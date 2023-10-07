{ config , lib, pkgs , ...}:

let
  inherit (lib) mkIf;
  inherit (lib.dafos) mkBoolOpt;

  cfg = config.dafos.apps.alacritty;
in
{
  options.dafos.apps.alacritty = {
    enable = mkBoolOpt false "Whether or not to enable alacritty.";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        shell = { program = "${pkgs.zellij}/bin/zellij"; };
        tabspace = 4;
        mouse = { hide_cursor_typing = true; };
        window = {
          opacity = 1;
          decorations = "none";
          padding = { x = 8; y = 8; };
          dynamic_padding = true;
          startup_mode = "Maximized";
        };
        font = {
          size = 12.0;
          normal = { family = "Sarasa Term K"; };
        };
        colors = {
          primary = {
            background = "#1b2b34";
            foreground = "#d8dee9";
          };

          # dim_foreground = "#9a9a9a"
          # bright_foreground = "#ffffff"

          # Colors the cursor will use if `custom_cursor_colors` is true
          cursor = {
            text = "#000000";
            cursor = "#ffffff";
          };

          # Theme: Gruvbox Dark
          # Normal colors
          normal = {
            black = "#343d46";
            red = "#ec5f67";
            green = "#99c794";
            yellow = "#fac863";
            blue = "#6699cc";
            magenta = "#c594c5";
            cyan = "#5fb3b3";
            white = "#cdd3de";
          };

          # Bright colors
          bright = {
            black = "#343d46";
            red = "#ec5f67";
            green = "#99c794";
            yellow = "#fac863";
            blue = "#6699cc";
            magenta = "#c594c5";
            cyan = "#5fb3b3";
            white = "#cdd3de";
          };

          # Dim colors (Optional)
          dim = {
            black = "#333333";
            red = "#f2777a";
            green = "#99cc99";
            yellow = "#ffcc66";
            blue = "#6699cc";
            magenta = "#cc99cc";
            cyan = "#66cccc";
            white = "#dddddd";
          };
        };
      };
    };
  };
}
