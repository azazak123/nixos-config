{ config, lib, pkgs, ... }:
{
  services.nginx = {
    enable = true;
    appendHttpConfig = ''
      map $http_upgrade $connection_upgrade {
        default upgrade;
        "" close;
      }
    '';
    virtualHosts = {
      "azazak123.dedyn.io" = {
        forceSSL = true;
        useACMEHost = "azazak123.dedyn.io";
        locations."/" = {
          return = "301 https://filebrowser.azazak123.dedyn.io$request_uri";
        };
      };
      "jellyfin.azazak123.dedyn.io" = {
        forceSSL = true;
        useACMEHost = "azazak123.dedyn.io";
        locations."/" = {
          extraConfig = ''
            proxy_pass http://127.0.0.1:8096;
            proxy_redirect off;
            proxy_set_header  Host $host;
            proxy_set_header  X-Real-IP $remote_addr;
            proxy_set_header  X-Forwarded-Proto https;
            proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Proto $scheme;
            client_max_body_size 0;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection $connection_upgrade;
          '';
        };
      };
      "jellyseer.azazak123.dedyn.io" = {
        forceSSL = true;
        useACMEHost = "azazak123.dedyn.io";
        locations."/" = {
          extraConfig = ''
            proxy_pass http://127.0.0.1:5055;
            proxy_redirect off;
            proxy_set_header  Host $host;
            proxy_set_header  X-Real-IP $remote_addr;
            proxy_set_header  X-Forwarded-Proto https;
            proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Proto $scheme;
            client_max_body_size 0;
          '';
        };
      };
      "immich.azazak123.dedyn.io" = {
        forceSSL = true;
        useACMEHost = "azazak123.dedyn.io";
        locations."/" = {
          extraConfig = ''
            proxy_pass http://127.0.0.1:2283;
            proxy_redirect off;
            proxy_set_header  Host $host;
            proxy_set_header  X-Real-IP $remote_addr;
            proxy_set_header  X-Forwarded-Proto https;
            proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Proto $scheme;
            client_max_body_size 0;
          '';
        };
      };
      "wishlist.azazak123.dedyn.io" = {
        forceSSL = true;
        useACMEHost = "azazak123.dedyn.io";
        locations."/" = {
          extraConfig = ''
            proxy_pass http://127.0.0.1:3280;
            proxy_redirect off;
            proxy_set_header  Host $host;
            proxy_set_header  X-Real-IP $remote_addr;
            proxy_set_header  X-Forwarded-Proto https;
            proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Proto $scheme;
            client_max_body_size 0;
            proxy_buffer_size   128k;
            proxy_buffers   4 256k;
            proxy_busy_buffers_size   256k;
          '';
        };
      };
      "board.azazak123.dedyn.io" = {
        forceSSL = true;
        useACMEHost = "azazak123.dedyn.io";
        locations."/" = {
          extraConfig = ''
            proxy_pass http://127.0.0.1:8080;
            proxy_redirect off;
            proxy_set_header  Host $host;
            proxy_set_header  X-Real-IP $remote_addr;
            proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header  X-Forwarded-Proto $scheme;
            client_max_body_size 0;
            proxy_buffer_size   128k;
            proxy_buffers   4 256k;
            proxy_busy_buffers_size   256k;
          '';
        };
        locations."/socket.io/" = {
          extraConfig = ''
            proxy_pass http://127.0.0.1:8081;
            proxy_redirect off;
            proxy_set_header  Host $host;
            proxy_set_header  X-Real-IP $remote_addr;
            proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header  X-Forwarded-Proto $scheme;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_buffering off;
            proxy_read_timeout 86400;
            proxy_send_timeout 86400;
            client_max_body_size 0;
          '';
        };
      };
      "filebrowser.azazak123.dedyn.io" = {
        forceSSL = true;
        useACMEHost = "azazak123.dedyn.io";
        locations."/" = {
          proxyPass = "http://127.0.0.1:1212";
          proxyWebsockets = true;
          extraConfig = ''
            client_max_body_size 0;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
          '';
        };
      };
    };
  };
}
