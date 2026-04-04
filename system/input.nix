{ pkgs, ... }:

{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        leftalt = "leftcontrol";
        rightalt = "rightcontrol";
        rightcontrol = "rightalt";
        capslock = "overload(alt, esc)";
        enter = "overload(alt, enter)";
      };
    };
  };

  services.xserver.xkb = {
    layout = "us,ua";
    variant = "colemak,";
    options = "grp:menu_toggle";
  };

  console = {
    earlySetup = true;
    font = "ter-v32n";
    packages = with pkgs; [ terminus_font ];
    useXkbConfig = true;
  };
}
