{
  config,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.emulators.kitty;
  fontTerm = config.${namespace}.user.font.mono;
in
{
  options.${namespace}.programs.terminal.emulators.kitty = {
    enable = mkBoolOpt false "Whether or not to enable kitty.";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font.name = fontTerm;
      font.size = 12;
      themeFile = "everforest_dark_soft";
      shellIntegration.enableFishIntegration = true;
      settings = {
        # Cursor
        cursor_shape = "underline";
        cursor_underline_thicness = "2.0";
        cursor_blink_interval = -1;
        cursor_stop_blinking_after = "15.0";

        # Scrollback
        scrollback_lines = 10000;
        scrollback_pager = "less";
        wheel_scroll_multiplier = "5.0";

        # Window
        remember_window_size = "no";
        initial_window_width = 800;
        initial_window_height = 600;
        window_border_width = 0;
        window_margin_width = 2;
        window_padding_width = 2;
        inactive_text_alpha = "1.0";
        background_opacity = "0.99";
        placement_strategy = "center";
        hide_window_decorations = "yes";
        confirm_os_window_close = 0;

        # Layouts
        enabled_layouts = "*";

        # Tabs
        tab_bar_edge = "bottom";
        tab_bar_style = "hidden";

        # Shell
        shell = ".";
      };
    };
  };
}
