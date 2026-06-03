{ config, pkgs, lib, inputs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common/boot.nix
    ../../modules/common/networking.nix
    ../../modules/common/nix-settings.nix
    ../../modules/common/auto-update.nix
    ../../modules/common/gui/gnome.nix
  ];

  networking.hostName = "nixos-main";
  time.timeZone = "Europe/Paris";           # Change as needed
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "fr-latin1";
  services.xserver.layout = "fr";
  console.useXkbConfig = true;

  # User configuration
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    initialPassword = "admin";
  };

  # Enable sudo without password (optional but convenient)
  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "25.05";
}