{ pkgs, inputs, ... }: {

  imports = [
    #  ../../system/nix.nix
    ../../home/users/azazak123.nix
    ../../system/style.nix

  ];

  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.vim
      pkgs.git
      pkgs.htop
      pkgs.ripgrep
      pkgs.helix
    ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  #system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.defaults={
    controlcenter.BatteryShowPercentage = true;
    trackpad.SecondClickThreshold = 2;
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "clmv";
      ShowStatusBar = true;
    };
    dock = {
      # Top Left
      wvous-tl-corner = 2;   # Mission Control

      wvous-tr-corner = 1;
      # Bottom Left
      wvous-bl-corner = 4;   # Show Desktop

      # Bottom Right
      wvous-br-corner = 1;   # Disable hot corner
      mru-spaces = false;
      autohide = true;
      show-recents = false; # disable recent apps
      static-only = true;
    };
    CustomUserPreferences = {
      "com.apple.HIToolbox" = {
        AppleEnabledInputSources = [
          {
            InputSourceKind = "Keyboard Layout";
            "KeyboardLayout ID" = 12825;
            "KeyboardLayout Name" = "Colemak";
          }
          {
            InputSourceKind = "Keyboard Layout";
            "KeyboardLayout ID" = -2354;
            "KeyboardLayout Name" = "Ukrainian-PC";
          }
        ];
        AppleSelectedInputSources = [
          {
            InputSourceKind = "Keyboard Layout";
            "KeyboardLayout ID" = 12825;
            "KeyboardLayout Name" = "Colemak";
          }
        ];
        AppleGlobalTextInputProperties = {
          TextInputGlobalPropertyPerContextInput = 1;
        };
      };
      "com.apple.screencapture" = {
        target = "clipboard";
      };
      "com.apple.finder" = {
        DesktopViewSettings = {
          IconViewSettings = {
            arrangeBy = "grid";
          };
        };
        FK_StandardViewSettings = {
          IconViewSettings = {
            arrangeBy = "grid";
          };
        };
        StandardViewSettings = {
          IconViewSettings = {
            arrangeBy = "grid";
          };
        };
      };
      ".GlobalPreferences"."com.apple.keyboard.modifiermapping.9610-73-0" = [
        { HIDKeyboardModifierMappingSrc = 30064771129; HIDKeyboardModifierMappingDst = 30064771302; }  # CapsLock → R-Option
        { HIDKeyboardModifierMappingSrc = 30064771302; HIDKeyboardModifierMappingDst = 30064771300; }  # R-Option → R-Control
        { HIDKeyboardModifierMappingSrc = 30064771296; HIDKeyboardModifierMappingDst = 30064771298; }  # L-Control → L-Option
        { HIDKeyboardModifierMappingSrc = 30064771298; HIDKeyboardModifierMappingDst = 30064771296; }  # L-Option → L-Control
        { HIDKeyboardModifierMappingSrc = 30064771300; HIDKeyboardModifierMappingDst = 30064771302; }  # R-Control → R-Option
      ];
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          # Ctrl + 1..8 — перемикання Spaces
          "118" = { enabled = true; value = { parameters = [ 49 18 262144 ]; type = "standard"; }; };
          "119" = { enabled = true; value = { parameters = [ 50 19 262144 ]; type = "standard"; }; };
          "120" = { enabled = true; value = { parameters = [ 51 20 262144 ]; type = "standard"; }; };
          "121" = { enabled = true; value = { parameters = [ 52 21 262144 ]; type = "standard"; }; };
          "122" = { enabled = true; value = { parameters = [ 53 23 262144 ]; type = "standard"; }; };
          "123" = { enabled = true; value = { parameters = [ 54 22 262144 ]; type = "standard"; }; };
          "124" = { enabled = true; value = { parameters = [ 55 26 262144 ]; type = "standard"; }; };
          "125" = { enabled = true; value = { parameters = [ 56 28 262144 ]; type = "standard"; }; };

          # Mission Control — Ctrl+Up (32)
          "32" = { enabled = true; value = { parameters = [ 126 126 8650752 ]; type = "standard"; }; };
          # App Exposé — Ctrl+Down (34)
          "34" = { enabled = true; value = { parameters = [ 125 125 8650752 ]; type = "standard"; }; };
        };
      };
    };
  };

  system.primaryUser = "azazak123";
  system.activationScripts.postActivation.text = ''
    # Inject Nix PATH into launchd for user azazak123
  sudo -u azazak123 launchctl setenv PATH /run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/Users/azazak123/.nix-profile/bin:/usr/bin:/bin:/usr/sbin:/sbin
  '';
  networking.hostName = "kimura";
  networking.computerName = "kimura";

  homebrew = {
    enable = true;
    enableFishIntegration = true;

    onActivation = {
      cleanup = "zap";
    };

    # Third-party Homebrew taps (formulae)
    taps = [
    ];

    # GUI apps requiring deep system access
    casks = [
      "orcaslicer"
      "steam"
      "heroic"
    ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;
}
