{ config, pkgs, lib, inputs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common/boot.nix
    ../../modules/common/networking.nix
    ../../modules/common/nix-settings.nix
    ../../modules/common/auto-update.nix
  ];

  networking.hostName = "nixos-main";
  time.timeZone = "Europe/Paris";           # Change as needed
  i18n.defaultLocale = "en_US.UTF-8";

  # User configuration
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    initialPassword = "admin";
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable sudo without password (optional but convenient)
  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "25.05";
}