{ config , lib , options , pkgs , ...}:

let
  inherit (lib) types mkIf mkMerge;
  inherit (lib.dafos) mkBoolOpt mkOpt;

  cfg = config.dafos.apps.firefox;
  defaultSettings = {
    "accessibility.typeaheadfind.enablesound" = false;
    "accessibility.typeaheadfind.flashBar" = 0;
    "browser.aboutConfig.showWarning" = false;
    "browser.aboutwelcome.enabled" = false;
    "browser.bookmarks.autoExportHTML" = true;
    "browser.bookmarks.showMobileBookmarks" = true;
    "browser.meta_refresh_when_inactive.disabled" = true;
    "browser.newtabpage.activity-stream.default.sites" = "";
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.search.hiddenOneOffs" = "Google,Amazon.com,Bing,DuckDuckGo,eBay,Wikipedia (en)";
    "browser.search.suggest.enabled" = false;
    "browser.sessionstore.warnOnQuit" = true;
    "browser.shell.checkDefaultBrowser" = false;
    "browser.ssb.enabled" = true;
    "browser.startup.homepage.abouthome_cache.enabled" = true;
    "browser.startup.page" = 3;
    "browser.urlbar.keepPanelOpenDuringImeComposition" = true;
    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
    "dom.storage.next_gen" = true;
    "dom.webgpu.enabled" = true;
    "extensions.htmlaboutaddons.recommendations.enabled" = false;
    "general.autoScroll" = false;
    "general.smoothScroll.msdPhysics.enabled" = true;
    "geo.enabled" = false;
    "geo.provider.use_corelocation" = false;
    "geo.provider.use_geoclue" = false;
    "geo.provider.use_gpsd" = false;
    "intl.accept_languages" = "en-US = en";
    "media.eme.enabled" = true;
    "media.ffmpeg.vaapi.enabled" = true;
    # "media.hardware-video-decoding.force-enabled" = true;
    "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  };
in
{
  options.dafos.apps.firefox = with types; {
    enable = mkBoolOpt false "Whether or not to enable Firefox.";
    extraConfig =
      mkOpt str "" "Extra configuration for the user profile JS file.";
    settings = mkOpt attrs defaultSettings "Settings to apply to the profile.";
    userChrome =
      mkOpt str "" "Extra configuration for the user chrome CSS file.";
  };

  config = mkIf cfg.enable {
    services.gnome.gnome-browser-connector.enable = config.dafos.desktop.gnome.enable;

    dafos.home = {
      file = mkMerge [
        (mkIf config.dafos.desktop.gnome.enable {
          ".mozilla/native-messaging-hosts/org.gnome.chrome_gnome_shell.json".source = "${pkgs.chrome-gnome-shell}/lib/mozilla/native-messaging-hosts/org.gnome.chrome_gnome_shell.json";
        })
      ];

      extraOptions = {
        programs.firefox = {
          enable = true;

          package = pkgs.wrapFirefox pkgs.firefox-beta-unwrapped {
            cfg = {
              enableTridactylNative = true;
            };

            extraPolicies = {
              CaptivePortal = false;
              DisableFirefoxStudies = true;
              DisableFormHistory = true;
              DisablePocket = true;
              DisableTelemetry = true;
              DisplayBookmarksToolbar = true;
              DontCheckDefaultBrowser = true;
              FirefoxHome = {
                Pocket = false;
                Snippets = false;
              };
              PasswordManagerEnabled = false;
              # PromptForDownloadLocation = true;
              UserMessaging = {
                ExtensionRecommendations = false;
                SkipOnboarding = true;
              };
              ExtensionSettings = {
                "ebay@search.mozilla.org".installation_mode = "blocked";
                "amazondotcom@search.mozilla.org".installation_mode = "blocked";
                "bing@search.mozilla.org".installation_mode = "blocked";
                "ddg@search.mozilla.org".installation_mode = "blocked";
                "wikipedia@search.mozilla.org".installation_mode = "blocked";

                "frankerfacez@frankerfacez.com" = {
                  installation_mode = "force_installed";
                  install_url = "https://cdn.frankerfacez.com/script/frankerfacez-4.0-an+fx.xpi";
                };

                "magnolia_limited_permissions@12.34" = {
                  installation_mode = "force_installed";
                  install_url = "https://gitlab.com/magnolia1234/bpc-uploads/-/raw/master/bypass_paywalls_clean-3.2.3.0-custom.xpi";
                };
              };
              Preferences = { };
            };
          };

          profiles.${config.dafos.user.name} = {
            inherit (cfg) extraConfig userChrome settings;
            id = 0;
            inherit (config.dafos.user) name;
            extensions = with pkgs.nur.repos.rycee.firefox-addons; [
              bitwarden
              darkreader
              simple-tab-groups
              sponsorblock
              stylus
              tabcenter-reborn
              tridactyl
              ublock-origin
              user-agent-string-switcher
            ];
          };
        };

        # Tridactyl
        xdg.configFile."tridactyl/tridactylrc".source = ./tridactyl/tridactylrc;
        xdg.configFile."tridactyl/themes/everforest-dark.css".source = ./tridactyl/tridactyl_style_everforest.css;
      };
    };
  };
}
