{
  pkgs,
  modulesPath,
  inputs,
  lib,
  config,
  ...
}:

let
  programs = ../../programs;
in

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  networking.hostName = "osaka-nginx";

  nix = import /${programs}/nix-config.nix { inherit inputs lib config; };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  security.acme = {
    acceptTerms = true;
    defaults.email = "azazaka2002@gmail.com";
  };

  services.nginx = {
    enable = true;
    virtualHosts = {
      "azazak123.ddns.net" = {
        forceSSL = true;
        enableACME = true;
        locations."^~ /jellyseer" = {
          extraConfig = ''
            ## Set environment variables for use with SSO
            set $service_unit "jellyseerr";
            set $service_name_pretty "Jellyseerr";

            set $app 'jellyseerr';
            set $app_esc 'jellyseerr';

            # Remove /pods/direct/overseerr path to pass to the app
            rewrite ^/jellyseerr/?(.*)$ /$1 break;
            proxy_pass http://192.168.0.115:5055; # NO TRAILING SLASH

            # Redirect location headers
            proxy_redirect ^ /$app;
            proxy_redirect /setup /$app/setup;
            proxy_redirect /login /$app/login;

            # Sub filters to replace hardcoded paths
            proxy_set_header Accept-Encoding "";
            sub_filter_once off;
            sub_filter_types *;

            # HREF
            sub_filter 'href="/"' 'href="/$app/"';
            sub_filter 'href="/login"' 'href="/$app/login"';
            sub_filter 'href:"/"' 'href:"/$app/"';

            ## Capture some things which shouldn't change
            sub_filter '.id,"/' '.id,"/';
            sub_filter '"/settings/main' '"/settings/main';
            sub_filter '"/settings/password' '"/settings/password';
            sub_filter '"/settings/permissions' '"/settings/permissions';
            sub_filter '"/settings/notifications/email' '"/$app/settings/notifications/email';
            sub_filter 'webPushEnabled?"/settings/notifications/webpush"' 'webPushEnabled?"/settings/notifications/webpush"';
            sub_filter '"/settings/notifications/webpush' '"/$app/settings/notifications/webpush';
            sub_filter '"/settings/notifications/pushbullet' '"/$app/settings/notifications/pushbullet';
            sub_filter '"/settings/notifications/pushover' '"/$app/settings/notifications/pushover';
            # sub_filter '"/settings/notifications/pushover' '"/settings/notifications/pushover';
            sub_filter '"/settings/notifications' '"/settings/notifications';

            ## Now the remaining settings paths are ok to change
            sub_filter '"/settings' '"/$app/settings';

            ## Default filters:
            sub_filter '\/_next' '\/$app_esc\/_next';
            sub_filter '/_next' '/$app/_next';
            sub_filter '/api/v1' '/$app/api/v1';
            sub_filter '/login/plex/loading' '/$app/login/plex/loading';
            sub_filter '/images/' '/$app/images/';

            ## Route-specific filters:
            sub_filter '"/sw.js"' '"/$app/sw.js"';
            sub_filter '"/offline.html' '"/$app/offline.html';
            sub_filter '"/android-' '"/$app/android-';
            sub_filter '"/apple-' '"/$app/apple-';
            sub_filter '"/favicon' '"/$app/favicon';
            sub_filter '"/logo_' '"/$app/logo_';
            sub_filter '"/profile' '"/$app/profile';
            sub_filter '"/users' '"/$app/users';
            sub_filter '"/movie' '"/$app/movie';
            sub_filter '"/tv' '"/$app/tv';
            ### These are needed for request management
            # It looks like this one rule can be used intead of the below 3
            sub_filter '="/".concat' '="/$app/".concat';
            # sub_filter 't="/".concat(w,"/").concat(y,"?manage=1"' 't="/$app/".concat(w,"/").concat(y,"?manage=1"';
            # sub_filter 's="/".concat(N,"/").concat(y,"?manage=1"' 's="/$app/".concat(N,"/").concat(y,"?manage=1"';
            # sub_filter 't="/".concat(b,"/").concat(y,"?manage=1"' 't="/$app/".concat(b,"/").concat(y,"?manage=1"';
            ###

            # Fix WebPush action URL:
            sub_filter 'actionUrl: payload' 'actionUrl: \'/$app\' + payload';

            sub_filter '"/person' '"/$app/person';
            sub_filter '"/collection' '"/$app/collection';
            sub_filter '"/discover' '"/$app/discover';
            sub_filter '"/requests' '"/$app/requests';
            sub_filter '"/issues' '"/$app/issues';
            sub_filter '"/site.webmanifest' '"/$app/site.webmanifest';
            # Setting settings paths so that they don't match the generic replace

            # For routes in /profile
            sub_filter 'route:"/settings/password' 'route:"/settings/password';
            sub_filter 'regex:/^\/settings\/password' 'regex:/^\/settings\/password';
            sub_filter 'route:"/settings/permissions' 'route:"/settings/permissions';
            sub_filter 'regex:/^\/settings\/permissions' 'regex:/^\/settings\/permissions';
            sub_filter 'route:"/settings/main",regex:/\/settings(\/main)?' 'route:"/settings/main",regex:/\/settings(\/main)?';
            sub_filter 'route:"/settings/notifications/webpush",regex:/\/settings\/notifications\/webpush/,' 'route:"/settings/notifications/webpush",regex:/\/settings\/notifications\/webpush/,';
            sub_filter 'route:"/settings/notifications/pushbullet",regex:/\/settings\/notifications\/pushbullet/}' 'route:"/settings/notifications/pushbullet",regex:/\/settings\/notifications\/pushbullet/}';
            sub_filter 'route:"/settings/notifications/pushover",regex:/\/settings\/notifications\/pushover/}' 'route:"/settings/notifications/pushover",regex:/\/settings\/notifications\/pushover/}';
            sub_filter 'route:"/settings/notifications' 'route:"/$app/settings/notifications';
            sub_filter 'regex:/^\/settings\/notifications' 'regex:/^\/$app_esc\/settings\/notifications';

            # Generic route and regex replace
            sub_filter 'route:"/' 'route:"/$app/';
            sub_filter 'regex:/^\/' 'regex:/^\/$app_esc\/';
            sub_filter 'regex:/\/' 'regex:/\/$app_esc\/';
          '';
        };

        locations."/jellyfin/" = {
          extraConfig = ''
            proxy_pass http://192.168.0.115:8096/;
            proxy_redirect off;
            proxy_set_header  Host $host;
            proxy_set_header  X-Real-IP $remote_addr;
            proxy_set_header  X-Forwarded-Proto https;
            proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
            client_max_body_size 0;
          '';
        };

        locations."/" = {
          extraConfig = ''
            proxy_pass http://192.168.0.114:80/;
            proxy_set_header  Host $host;
            proxy_set_header  X-Real-IP $remote_addr;
            proxy_set_header  X-Forwarded-Proto https;
            proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
            client_max_body_size 0;
          '';
        };
      };
    };
  };

  services.openssh.enable = true;
  services.getty.autologinUser = "root";

  environment.systemPackages = [
    pkgs.vim
    pkgs.neofetch
  ];

  programs.fish.enable = true;

  programs.git.enable = true;

  system.stateVersion = "24.05";
}
