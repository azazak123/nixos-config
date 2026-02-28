{
  enable = true;
  settings = {
    RUNTIME_PM_ON_AC = "auto";
    RUNTIME_PM_ON_BAT = "auto";
    PCIE_ASPM_ON_BAT = "powersupersave";

    CPU_DRIVER_OPMODE_ON_AC = "guided";
    CPU_DRIVER_OPMODE_ON_BAT = "guided";

    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_SCALING_GOVERNOR_ON_SAV = "powersave";

    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    CPU_ENERGY_PERF_POLICY_ON_SAV = "power";

    RADEON_DPM_STATE_ON_AC = "performance";
    RADEON_DPM_STATE_ON_BAT = "battery";

    RADEON_DPM_PERF_LEVEL_ON_BAT = "low";

    USB_AUTOSUSPEND = "1";

    CPU_BOOST_ON_AC = "1";
    CPU_BOOST_ON_BAT = "0";
    CPU_BOOST_ON_SAV = "0";

    AMDGPU_ABM_LEVEL_ON_BAT = "3";

    CPU_SCALING_MAX_FREQ_ON_AC = "3900000";
    CPU_SCALING_MAX_FREQ_ON_BAT = "3900000";
    CPU_SCALING_MAX_FREQ_ON_SAV = "3900000";

    SOUND_POWER_SAVE_ON_AC = "0";
    SOUND_POWER_SAVE_ON_BAT = "1";
    SOUND_POWER_SAVE_CONTROLLER = "Y";

    NMI_WATCHDOG = "0";
  };
}
