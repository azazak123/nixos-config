{ config, lib, pkgs, ... }:
{
  services.tlp = {
    enable = true;
    settings = {
      SOUND_POWER_SAVE_CONTROLLER = "Y";
      DISK_DEVICES = "sda sdb sdc sdd sde sdf";
      DISK_IOSCHED = "mq-deadline mq-deadline mq-deadline mq-deadline mq-deadline mq-deadline";
      RUNTIME_PM_ON_AC = "on";
    };
  };
}
