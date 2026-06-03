{ config, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    flake = "github:yourusername/nixos-config#nixos-main";  # ← Update username + hostname
    flags = [ "--update-input" "nixpkgs" "--no-write-lock-file" ];
    dates = "04:00";
    randomizedDelaySec = "45min";
    allowReboot = false;
  };

  # Pull latest config from GitHub hourly
  systemd.services.pull-nixos-config = {
    description = "Pull latest NixOS config";
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.git}/bin/git -C /etc/nixos pull --ff-only";
      Restart = "on-failure";
    };
  };

  systemd.timers.pull-nixos-config = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "hourly";
      RandomizedDelaySec = "10min";
      Persistent = true;
    };
  };
}