{
  enable = true;
  settings = {
    TLP_DEFAULT_MODE = "AC";
    TLP_PERSISTENT_DEFAULT = 1;

    CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
    CPU_BOOST_ON_AC = 1;

    DISK_APM_LEVEL_ON_AC = "254 254";
    DISK_SPINDOWN_TIMEOUT_ON_AC = "0";

    USB_AUTOSUSPEND = 0;

    RUNTIME_PM_ON_AC = "on";
    PCIE_ASPM_ON_AC = "default";
  };
}
