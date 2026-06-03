{ pkgs, ... }:

{
  home.username = "youruser";
  home.homeDirectory = "/home/youruser";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    git
    neovim
    htop
    btop
  ];

  programs.git = {
    enable = true;
    userName = "Your Name";
    userEmail = "you@example.com";
  };

  programs.home-manager.enable = true;
}