{ pkgs, ... }:

{
  programs.gamescope.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };

  environment.systemPackages = with pkgs; [
    protonup-qt
    mangohud
  ];

  # Gaming-optimized sysctl (adopted from Jovian SteamOS defaults)
  boot.kernel.sysctl = {
    # Scheduler: lower latency for foreground/gaming workloads
    "kernel.sched_cfs_bandwidth_slice_us" = 3000;
    "kernel.sched_latency_ns" = 3000000;         # 3ms target latency
    "kernel.sched_min_granularity_ns" = 300000;   # 0.3ms min slice
    "kernel.sched_wakeup_granularity_ns" = 500000; # 0.5ms wakeup preemption
    "kernel.sched_migration_cost_ns" = 50000;     # 50us migration cost
    "kernel.sched_nr_migrate" = 128;

    # Gaming
    "vm.max_map_count" = 2147483642;  # near INT_MAX, needed by many games
    "net.ipv4.tcp_fin_timeout" = 5;   # faster port reuse after game restart
    "kernel.split_lock_mitigate" = 0;  # disable split-lock mitigation (perf)
  };

  # OOM killer — kill runaway processes before system locks up
  services.earlyoom = {
    enable = true;
    extraArgs = [
      "-M" "409600,307200"
      "-S" "409600,307200"
    ];
  };
}
