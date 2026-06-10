{ config, pkgs, ... }:

{
  # Btrfs tools
  environment.systemPackages = with pkgs; [
    btrfs-progs
    duperemove
    compsize
  ];

  # zram - compressed swap in RAM
  zramSwap = {
    enable = true;
    memoryPercent = 50;
    algorithm = "zstd";
  };

  # Memory tuning for zswap + AI workloads
  boot.kernel.sysctl = {
    # Balanced reclaim - with zswap, swapping is cheap
    "vm.swappiness" = 100;

    # No swap readahead - compressed pages have no locality
    "vm.page-cluster" = 0;

    # Don't boost watermarks - let zswap handle pressure
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;

    # Flush dirty pages earlier to avoid IO spikes
    "vm.dirty_ratio" = 10;
    "vm.dirty_background_ratio" = 5;

    # Keep inode/dentry caches longer
    "vm.vfs_cache_pressure" = 50;

    # Allow overcommit for AI model mmap loading
    "vm.overcommit_memory" = 0;
    "vm.overcommit_ratio" = 80;
  };

  # zswap kernel parameters
  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.compressor=zstd"
    "zswap.zpool=zsmalloc"
    "zswap.max_pool_percent=50"
  ];

  # Btrfs per-directory compression policies
  systemd.services.btrfs-compression-policies = {
    description = "Set btrfs per-directory compression policies";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      # High compression for code, docs, configs
      for dir in /home/*/Documents /home/*/Projects /home/*/.config /var/log; do
        if [ -d "$dir" ]; then
          ${pkgs.btrfs-progs}/bin/btrfs property set "$dir" compression zstd:9 2>/dev/null || true
        fi
      done

      # Default compression for general home
      for dir in /home/*; do
        if [ -d "$dir" ]; then
          ${pkgs.btrfs-progs}/bin/btrfs property set "$dir" compression zstd:4 2>/dev/null || true
        fi
      done

      # No compression for AI models
      for dir in /opt/models /home/*/models /home/*/.ollama; do
        if [ -d "$dir" ]; then
          ${pkgs.btrfs-progs}/bin/btrfs property set "$dir" compression no 2>/dev/null || true
        fi
      done

      # No compression for media
      for dir in /home/*/Videos /home/*/Music /home/*/Pictures /home/*/Media; do
        if [ -d "$dir" ]; then
          ${pkgs.btrfs-progs}/bin/btrfs property set "$dir" compression no 2>/dev/null || true
        fi
      done
    '';
  };

  # AI workload memory isolation
  systemd.slices.ai-workload = {
    description = "AI Workload Isolation Slice";
    sliceConfig = {
      MemoryHigh = "80%";
      MemoryMax = "90%";
    };
  };

  # Btrfs deduplication service
  systemd.services.btrfs-dedup = {
    description = "Btrfs deduplication with duperemove";
    serviceConfig = {
      Type = "oneshot";
      IOSchedulingClass = "idle";
      ExecStart = "${pkgs.duperemove}/bin/duperemove -rdh /home";
    };
  };

  # Run dedup weekly
  systemd.timers.btrfs-dedup = {
    description = "Weekly btrfs deduplication";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
    };
  };
}
