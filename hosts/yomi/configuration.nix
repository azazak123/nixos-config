# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  programs = ../../programs;
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only
  boot.supportedFilesystems = [ "zfs" ];
  boot.loader.grub.mirroredBoots = [
    {
      devices = [ "/dev/disk/by-uuid/5141-69CA" ];
      path = "/boot-fallback";
    }
  ];

  networking.hostName = "yomi"; # Define your hostname.
  networking.hostId = "12345678";
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.azazak123 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    helix
    htop
    neofetch
    smartmontools
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD"; # Or "i965" if using older driver
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };      # Same here
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      # intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
      libva-vdpau-driver # Previously vaapiVdpau
      # intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      # OpenCL support for intel CPUs before 12th gen
      # see: https://github.com/NixOS/nixpkgs/issues/356535
      intel-compute-runtime-legacy1 
      # vpl-gpu-rt # QSV on 11th gen or newer
      intel-media-sdk # QSV up to 11th gen
      intel-ocl # OpenCL support
    ];
  };

  users.groups.multimedia = {};

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [
        8000
        8082
      ];
    };
  };

  services = {
    nginx = {
      enable = true;
      virtualHosts."_" = {
        listen = [
          {
            addr = "0.0.0.0";
            port = 8082;
          }
        ];
        locations = {
          "/" = {
            proxyPass = "http://unix:/run/seahub/gunicorn.sock";
            extraConfig = ''
              proxy_set_header   Host $host;
              proxy_set_header   X-Real-IP $remote_addr;
              proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header   X-Forwarded-Host $server_name;
              proxy_set_header   X-Forwarded-Proto $scheme;
              proxy_read_timeout  1200s;
              client_max_body_size 0;
            '';
          };

          "/seafhttp/" = {
            proxyPass = "http://unix:/run/seafile/server.sock";
            extraConfig = ''
              rewrite ^/seafhttp(.*)$ $1 break;
              proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header   Host $host;
              proxy_connect_timeout  36000s;
              proxy_read_timeout  36000s;
              proxy_send_timeout  36000s;
              send_timeout  36000s;
              client_max_body_size 0;
            '';
          };
        };
      };
    };

    # Network shares
    samba = {
      package = pkgs.samba4Full;
      # ^^ `samba4Full` is compiled with avahi, ldap, AD etc support (compared to the default package, `samba`
      # Required for samba to register mDNS records for auto discovery
      # See https://github.com/NixOS/nixpkgs/blob/592047fc9e4f7b74a4dc85d1b9f5243dfe4899e3/pkgs/top-level/all-packages.nix#L27268
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "guest account" = "nobody";
          "map to guest" = "Bad User";
        };

        tmp = {
          path = "/mnt/mediatank/tmp";
          writable = "true";
          browseable = "yes";
          "guest ok" = "yes";
        };

        data = {
          path = "/mnt/datavault/vault";
          writable = "true";
          browseable = "yes";
          "guest ok" = "yes";
        };
      };
    };

    avahi = {
      publish.enable = true;
      publish.userServices = true;
      # ^^ Needed to allow samba to automatically register mDNS records (without the need for an `extraServiceFile`
      nssmdns4 = true;
      # ^^ Not one hundred percent sure if this is needed- if it aint broke, don't fix it
      enable = true;
      openFirewall = true;
    };

    samba-wsdd = {
      # This enables autodiscovery on windows since SMB1 (and thus netbios) support was discontinued
      enable = true;
      openFirewall = true;
    };

    tlp = {
      enable = true;
      settings = {
        SOUND_POWER_SAVE_CONTROLLER = "Y";

        DISK_DEVICES = "sda sdb sdc sdd sde sdf";
        DISK_IOSCHED = "mq-deadline mq-deadline mq-deadline mq-deadline mq-deadline mq-deadline";

        RUNTIME_PM_ON_AC = "on";
      };
    };

    immich = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
      mediaLocation = "/mnt/datavault/photo/immich";
    };

    seafile = {
      enable = true;
      adminEmail = "azazaka2002@gmail.com";
      initialAdminPassword = "changeme";

      ccnetSettings.General.SERVICE_URL = "http://192.168.0.106:8082"; # додай http://
      seafileSettings.fileserver.host = "unix:/run/seafile/server.sock";

      seahubExtraConf = ''
        CSRF_TRUSTED_ORIGINS = [ "http://192.168.0.106:8082" ];
      '';
      
      dataDir = "/mnt/datavault/data/seafile";

      gc = {
        enable = true;
        dates = [ "Sun 20:00:00" ];
      };
    };

    sonarr = {
      enable = true;
      group = "multimedia";
      openFirewall = true;
    };
    
    radarr = {
      enable = true;
      group = "multimedia";
      openFirewall = true;
    };

    prowlarr = {
      enable = true;
      openFirewall = true;
    };

    transmission = {
      enable = true;
      openFirewall = true;
      group = "multimedia";
      settings = {
        download-dir = "/mnt/mediatank/downloads/transmission/downloaded";
        incomplete-dir = "/mnt/mediatank/downloads/transmission/.incomplete";
        umask = 2;
      };
    };

    jellyfin = {
      enable = true;
      group = "multimedia";
      openFirewall = true;
    };
  
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };
  };

   systemd.services.transmission.serviceConfig = {
    Restart = "always";
    RestartSec = 30;
  };

  systemd.tmpfiles.rules = [
    "d /mnt/datavault/photo/immich 0755 immich immich -"
    "d /mnt/datavault/data/seafile 0755 seafile seafile - -"
    
    "d /mnt/datavault/vault 0777 nobody nogroup -"
    "z /mnt/datavault/vault/* 0777 nobody nogroup -"
    
    "d /mnt/mediatank/tmp 0777 nobody nogroup -"
    "z /mnt/mediatank/tmp/* 0777 nobody nogroup -"

    "d /mnt/mediatank/downloads/transmission 0775 transmission multimedia - -"
    "d /mnt/mediatank/downloads/transmission/downloaded 0775 transmission multimedia - -"
    "d /mnt/mediatank/downloads/transmission/.incomplete 0775 transmission multimedia - -"
    
    "d /mnt/mediatank/media/arr/shows 0775 sonarr multimedia - -"
    "d /mnt/mediatank/media/arr/movies 0775 radarr multimedia - -"
  ];

  programs = {
    fish.enable = true;
    git.enable = true;
    direnv.enable = true;
  };

  nix = import /${programs}/nix-config.nix { inherit inputs lib config; };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
