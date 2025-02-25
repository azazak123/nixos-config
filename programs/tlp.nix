{
  enable = true;
  settings = {
    RUNTIME_PM_ON_AC = "on";

    CPU_DRIVER_OPMODE_ON_AC = "guided";
    CPU_DRIVER_OPMODE_ON_BAT = "guided";

    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

    RADEON_DPM_STATE_ON_AC = "performance";
    RADEON_DPM_STATE_ON_BAT = "battery";

    USB_AUTOSUSPEND = "0";

    CPU_SCALING_MIN_FREQ_ON_AC = "400000";
    CPU_SCALING_MAX_FREQ_ON_AC = "3900000";
    CPU_SCALING_MIN_FREQ_ON_BAT = "400000";
    CPU_SCALING_MAX_FREQ_ON_BAT = "3900000";
  };
}
