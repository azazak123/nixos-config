{ ... }:

{
  stylix.targets.floorp.profileNames = [ "azazak123" ];

  programs.floorp = {
    enable = true;
    profiles.azazak123 = {
      isDefault = true;
      settings = {
        "browser.startup.page" = 3;
        "browser.sessionstore.interval" = 600000;
        "browser.download.useDownloadDir" = false;
        "browser.tabs.closeWindowWithLastTab" = false;
        "signon.rememberSignons" = false;
        "privacy.donottrackheader.enabled" = true;
        "network.dns.disablePrefetch" = true;
        "network.prefetch-next" = false;
        "network.http.speculative-parallel-limit" = 0;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "browser.ping-centre.telemetry" = false;
        "experiments.supported" = false;
        "network.allow-experiments" = false;
        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
      };
    };
  };
}
