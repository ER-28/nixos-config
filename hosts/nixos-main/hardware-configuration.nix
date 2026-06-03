{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # You will replace this file after first installation
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" = { device = "/dev/nvme0n1p2"; fsType = "ext4"; };  # Change this
  fileSystems."/boot" = { device = "/dev/nvme0n1p1"; fsType = "vfat"; };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}