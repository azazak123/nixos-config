{ pkgs, ... }:

{
  # Time and locale
  time.timeZone = "Europe/Kyiv";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };

  # Auto login
  services.getty.autologinUser = "azazak123";
  security.polkit.enable = true;

  # Shared packages
  environment.systemPackages = with pkgs; [
    vim
    neofetch
    cpufrequtils
    htop
    ncpamixer
    brightnessctl
    simple-scan
    bluetui
    ncdu
    yazi
    zip
    unzip
    ripgrep
  ];

  madness.enable = true;
}
