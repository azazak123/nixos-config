{
  enable = true;
  settings = {
    RUNTIME_PM_ON_AC = "on";

    CPU_DRIVER_OPMODE_ON_AC = "guided";
    CPU_DRIVER_OPMODE_ON_BAT = "guided";

    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
    CPU_SCALING_GOVERNOR_ON_SAV = "schedutil";

    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    CPU_ENERGY_PERF_POLICY_ON_SAV = "power";

    RADEON_DPM_STATE_ON_AC = "performance";
    RADEON_DPM_STATE_ON_BAT = "battery";

    USB_AUTOSUSPEND = "0";

    CPU_BOOST_ON_AC = "1";
    CPU_BOOST_ON_BAT = "0";
    CPU_BOOST_ON_SAV = "0";

    AMDGPU_ABM_LEVEL_ON_BAT = "3";

    CPU_SCALING_MAX_FREQ_ON_AC = "3900000";
    CPU_SCALING_MAX_FREQ_ON_BAT = "3900000";
    CPU_SCALING_MAX_FREQ_ON_SAV = "3900000";
  };
}
