{ pkgs, ... }:

let
  retroarch-with-cores = pkgs.retroarch.withCores (c: with c; [
    swanstation
    fbneo
  ]);
in
{
  home.packages = with pkgs; [
    duckstation
    retroarch-with-cores

    flycast

    simple64

    pcsx2

    rpcs3

    eden

    mame
    supermodel
  ];

  # Desktop entry for DuckStation (AppImage doesn't provide one)
  xdg.desktopEntries.duckstation = {
    name = "DuckStation";
    exec = "duckstation %f";
    icon = "duckstation";
    type = "Application";
    categories = [ "Game" "Emulator" ];
    mimeType = [ "application/x-cd-image" ];
  };

  # SRM parsers — declarative ROM-to-Steam registration
  xdg.configFile."steam-rom-manager/userConfigurations.json".text = builtins.toJSON [
    # PS1 — DuckStation (standalone)
    {
      parserType = "Glob";
      configTitle = "PS1 - DuckStation";
      steamDirectory = "~/.steam/steam";
      romDirectory = "/mnt/tank/games/Consoles/ps1";
      executablePath = "duckstation";
      executableArgs = "-batch -nogui \"%ROM%\"";
      startInDirectory = "";
      titleModifier = "\${f0}";
      imageProviders = [ "SteamGridDB" ];
      onlineImageRequests = true;
      imageArgs = "";
      fileExtensions = [ "7z" "iso" "bin" "cue" "cbn" "chd" "img" "mdf" "mds" "pbp" "pse" "psf" "rvz" "cso" ];
      fileTypes = [ "compressed" ];
      category = "PS1";
      recursive = false;
      advanced = false;
    }

    # PS1 — SwanStation (RetroArch core)
    {
      parserType = "Glob";
      configTitle = "PS1 - SwanStation (RetroArch)";
      steamDirectory = "~/.steam/steam";
      romDirectory = "/mnt/tank/games/Consoles/ps1";
      executablePath = "retroarch";
      executableArgs = "-L swanstation \"%ROM%\"";
      startInDirectory = "";
      titleModifier = "\${f0} [SwanStation]";
      imageProviders = [ "SteamGridDB" ];
      onlineImageRequests = true;
      imageArgs = "";
      fileExtensions = [ "7z" "iso" "bin" "cue" "cbn" "chd" "img" "mdf" "mds" "pbp" "pse" "psf" "rvz" "cso" ];
      fileTypes = [ "compressed" ];
      category = "PS1";
      recursive = false;
      advanced = false;
    }

    # Dreamcast — Flycast
    {
      parserType = "Glob";
      configTitle = "Dreamcast - Flycast";
      steamDirectory = "~/.steam/steam";
      romDirectory = "/mnt/tank/games/Consoles/dreamcast";
      executablePath = "flycast";
      executableArgs = "\"%ROM%\"";
      startInDirectory = "";
      titleModifier = "\${f0}";
      imageProviders = [ "SteamGridDB" ];
      onlineImageRequests = true;
      imageArgs = "";
      fileExtensions = [ "7z" "iso" "gdi" "chd" "cdi" "nrg" ];
      fileTypes = [ "compressed" ];
      category = "Dreamcast";
      recursive = false;
      advanced = false;
    }

    # N64 — simple64
    {
      parserType = "Glob";
      configTitle = "N64 - simple64";
      steamDirectory = "~/.steam/steam";
      romDirectory = "/mnt/tank/games/Consoles/n64";
      executablePath = "simple64";
      executableArgs = "\"%ROM%\"";
      startInDirectory = "";
      titleModifier = "\${f0}";
      imageProviders = [ "SteamGridDB" ];
      onlineImageRequests = true;
      imageArgs = "";
      fileExtensions = [ "zip" "n64" "v64" "z64" "rom" "mbm" ];
      fileTypes = [ "compressed" ];
      category = "N64";
      recursive = false;
      advanced = false;
    }

    # PS2 — PCSX2
    {
      parserType = "Glob";
      configTitle = "PS2 - PCSX2";
      steamDirectory = "~/.steam/steam";
      romDirectory = "/mnt/tank/games/Consoles/ps2";
      executablePath = "pcsx2-qt";
      executableArgs = "\"%ROM%\"";
      startInDirectory = "";
      titleModifier = "\${f0}";
      imageProviders = [ "SteamGridDB" ];
      onlineImageRequests = true;
      imageArgs = "";
      fileExtensions = [ "7z" "iso" "bin" "img" "mdf" "nrg" "cso" "chd" "gz" ];
      fileTypes = [ "compressed" ];
      category = "PS2";
      recursive = false;
      advanced = false;
    }

    # PS3 — RPCS3
    {
      parserType = "Glob";
      configTitle = "PS3 - RPCS3";
      steamDirectory = "~/.steam/steam";
      romDirectory = "/mnt/tank/games/Consoles/ps3";
      executablePath = "rpcs3";
      executableArgs = "\"%ROM%\"";
      startInDirectory = "";
      titleModifier = "\${f0}";
      imageProviders = [ "SteamGridDB" ];
      onlineImageRequests = true;
      imageArgs = "";
      fileExtensions = [ "iso" "bin" "pkg" "edat" ];
      fileTypes = [];
      category = "PS3";
      recursive = true;
      advanced = false;
    }

    # Switch — Eden
    {
      parserType = "Glob";
      configTitle = "Switch - Eden";
      steamDirectory = "~/.steam/steam";
      romDirectory = "/mnt/tank/games/Consoles/switch/games";
      executablePath = "eden";
      executableArgs = "\"%ROM%\"";
      startInDirectory = "";
      titleModifier = "\${f0}";
      imageProviders = [ "SteamGridDB" ];
      onlineImageRequests = true;
      imageArgs = "";
      fileExtensions = [ "nsp" "xci" "nca" "nro" ];
      fileTypes = [];
      category = "Switch";
      recursive = false;
      advanced = false;
    }

    # Arcade — MAME
    {
      parserType = "Glob";
      configTitle = "Arcade - MAME";
      steamDirectory = "~/.steam/steam";
      romDirectory = "/mnt/tank/games/Consoles/arcade";
      executablePath = "mame";
      executableArgs = "\"%ROM%\"";
      startInDirectory = "";
      titleModifier = "\${f0}";
      imageProviders = [ "SteamGridDB" ];
      onlineImageRequests = true;
      imageArgs = "";
      fileExtensions = [ "zip" "7z" "chd" ];
      fileTypes = [ "compressed" ];
      category = "Arcade";
      recursive = true;
      advanced = false;
    }

    # Arcade — FBNeo (RetroArch core)
    {
      parserType = "Glob";
      configTitle = "Arcade - FBNeo (RetroArch)";
      steamDirectory = "~/.steam/steam";
      romDirectory = "/mnt/tank/games/Consoles/arcade";
      executablePath = "retroarch";
      executableArgs = "-L fbneo \"%ROM%\"";
      startInDirectory = "";
      titleModifier = "\${f0} [FBNeo]";
      imageProviders = [ "SteamGridDB" ];
      onlineImageRequests = true;
      imageArgs = "";
      fileExtensions = [ "zip" ];
      fileTypes = [ "compressed" ];
      category = "Arcade";
      recursive = true;
      advanced = false;
    }

    # Arcade — Supermodel (Sega Model 3)
    {
      parserType = "Glob";
      configTitle = "Arcade - Supermodel (Sega Model 3)";
      steamDirectory = "~/.steam/steam";
      romDirectory = "/mnt/tank/games/Consoles/arcade/model3";
      executablePath = "supermodel";
      executableArgs = "\"%ROM%\"";
      startInDirectory = "";
      titleModifier = "\${f0} [Model 3]";
      imageProviders = [ "SteamGridDB" ];
      onlineImageRequests = true;
      imageArgs = "";
      fileExtensions = [ "zip" ];
      fileTypes = [ "compressed" ];
      category = "Arcade";
      recursive = false;
      advanced = false;
    }
  ];
}
