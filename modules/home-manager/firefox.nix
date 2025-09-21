{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles = {
      ca1 = {
        isDefault = true;

        search.force = true;
        search.default = "ddg";
        search.engines = {
          "bing".metaData.hidden = true;
          "google".metaData.hidden = true;
          "wikipedia".metaData.hidden = true;
        };

        bookmarks = {
          force = true;
          settings = [{
            name = "toolbar";
            toolbar = true;
            bookmarks = [
              {
                name = "";
                url = "https://youtube.com/";
              }
              {
                name = "";
                url = "https://twitch.tv/";
              }
              {
                name = "";
                url = "https://tumblr.com/dashboard/";
              }
              {
                name = "";
                url = "https://github.com/";
              }
              {
                name = "";
                url = "https://monkeytype.com/";
              }
              {
                name = "";
                url = "https://orteil.dashnet.org/cookieclicker/";
              }
              {
                name = "";
                url = "https://wikipedia.org/";
              }
              {
                name = "";
                url = "https://developer.mozilla.org/";
              }
              {
                name = "";
                url = "https://listen.tidal.com/";
              }
            ];
          }];
        };

        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          darkreader
          tampermonkey
          config.theme.firefoxTheme
        ];

        settings = {
          "browser.aboutwelcome.enabled" = false;
          "datareporting.policy.firstRunURL" = "";

          # preferences
          "layout.css.prefers-color-scheme.content-override" = 0; # prefer dark mode
          "middlemouse.paste" = false;
          "general.autoScroll" = true;
          "media.eme.enabled" = true;
          "browser.download.useDownloadDir" = false;
          "signon.rememberSignons" = false; # don't save passwords
          "browser.formfill.enable" = false; # disable all autofill

          # layout
          "browser.toolbars.bookmarks.visibility" = "never";
          "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
          "browser.newtabpage.activity-stream.topSitesRows" = 0;
          "browser.newtabpage.activity-stream.logowordmark.alwaysVisible" = false;
          "browser.download.autohideButton" = true;
          "devtools.toolbox.host" = "right";
          "browser.tabs.inTitlebar" = 0; # get rid of close, maximise and minimise buttons in titlebar
          "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["addon_darkreader_org-browser-action","ublock0_raymondhill_net-browser-action","firefox_tampermonkey_net-browser-action","frankerfacez_frankerfacez_com-browser-action","adguard-extra-beta_adguard_com-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","history-panelmenu","customizableui-special-spring16","vertical-spacer","urlbar-container","save-to-pocket-button","customizableui-special-spring9","downloads-button","fxa-toolbar-menu-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":[],"vertical-tabs":["tabbrowser-tabs"],"PersonalToolbar":["personal-bookmarks"]},"seen":["developer-button","ublock0_raymondhill_net-browser-action","addon_darkreader_org-browser-action","firefox_tampermonkey_net-browser-action","frankerfacez_frankerfacez_com-browser-action","adguard-extra-beta_adguard_com-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","unified-extensions-area","toolbar-menubar","TabsToolbar","vertical-tabs"],"currentVersion":22,"newElementCount":16}'';
          "browser.uiCustomization.navBarWhenVerticalTabs" = ''["back-button","forward-button","stop-reload-button","history-panelmenu","vertical-spacer","panic-button","urlbar-container","save-to-pocket-button","downloads-button","fxa-toolbar-menu-button","unified-extensions-button"]'';

          # vertical tabs stuff
          "sidebar.verticalTabs" = true;
          "sidebar.new-sidebar.has-used" = true; # stop firefox from putting annoying stuff in the sidebar
          "sidebar.revamp.round-content-area" = true;
          "browser.toolbarbuttons.introduced.sidebar-button" = true; # stop toggle sidebar button from reappearing after restart
          "sidebar.backupState" = ''{"panelOpen":false,"launcherWidth":250,"launcherExpanded":false,"launcherVisible":true}''; # make sidebar start minimised

          # disable useless features and popups
          "extensions.pocket.enabled" = false;
          "identity.fxaccounts.enabled" = false;
          "identity.fxaccounts.toolbar.enabled" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;

          # address bar suggestions
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.suggest.history" = false;
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.topsites" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.recentsearches" = false;

          # clear on shutdown
          "privacy.sanitize.sanitizeOnShutdown" = true;
          "privacy.clearOnShutdown.cache" = false;
          "privacy.clearOnShutdown.cookies" = false;
          "privacy.clearOnShutdown.offlineApps" = false;

          # network stuff
          "security.OCSP.require" = true;
          "network.trr.mode" = 2; # dns over https if available
          "dom.security.https_only_mode" = true;


          # telemetry
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.unified" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.healthreport.service.firstRun" = false;
        };
      };

      p = {
        id = 1;

        search.force = true;
        search.default = "ddg";
        search.engines = {
          "bing".metaData.hidden = true;
          "google".metaData.hidden = true;
          "wikipedia".metaData.hidden = true;
        };

        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
        ];

        settings = {
          "privacy.resistFingerprinting" = true;
          "privacy.resistFingerprinting.letterboxing" = true;

          "extensions.activeThemeID" = "firefox-alpenglow@mozilla.org";
          "browser.toolbars.bookmarks.visibility" = "never";

          "browser.aboutwelcome.enabled" = false;
          "datareporting.policy.firstRunURL" = "";

          # preferences
          "middlemouse.paste" = false;
          "general.autoScroll" = true;
          "media.eme.enabled" = true;
          "browser.download.useDownloadDir" = false;
          "signon.rememberSignons" = false; # don't save passwords
          "browser.formfill.enable" = false; # disable all autofill

          # layout
          "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
          "browser.newtabpage.activity-stream.topSitesRows" = 0;
          "browser.newtabpage.activity-stream.logowordmark.alwaysVisible" = false;
          "browser.download.autohideButton" = true;
          "devtools.toolbox.host" = "right";
          "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":[],"nav-bar":["back-button","forward-button","stop-reload-button","history-panelmenu","panic-button","urlbar-container","save-to-pocket-button","downloads-button","fxa-toolbar-menu-button","ublock0_raymondhill_net-browser-action","addon_darkreader_org-browser-action","firefox_tampermonkey_net-browser-action","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["developer-button","ublock0_raymondhill_net-browser-action","addon_darkreader_org-browser-action","firefox_tampermonkey_net-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","unified-extensions-area","toolbar-menubar","TabsToolbar"],"currentVersion":20,"newElementCount":7}'';

          # disable useless features and popups
          "extensions.pocket.enabled" = false;
          "identity.fxaccounts.enabled" = false;
          "identity.fxaccounts.toolbar.enabled" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;

          # address bar suggestions
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.suggest.recentsearches" = false;
          "browser.urlbar.suggest.addons" = false;
          "browser.urlbar.suggest.amp" = false;
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.calculator" = false;
          "browser.urlbar.suggest.clipboard" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.fakespot" = false;
          "browser.urlbar.suggest.history" = false;
          "browser.urlbar.suggest.mdn" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.quickactions" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.remotetab" = false;
          "browser.urlbar.suggest.searches" = false;
          "browser.urlbar.suggest.topsites" = false;
          "browser.urlbar.suggest.trending" = false;
          "browser.urlbar.suggest.weather" = false;
          "browser.urlbar.suggest.wikipedia" = false;
          "browser.urlbar.suggest.yelp" = false;

          # clear on shutdown
          "privacy.sanitize.sanitizeOnShutdown" = true;

          # network stuff
          "security.OCSP.require" = true;
          "network.trr.mode" = 3; # dns over https
          "dom.security.https_only_mode" = true;

          # telemetry
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.unified" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.healthreport.service.firstRun" = false;
        };
      };
    };
  };
}
