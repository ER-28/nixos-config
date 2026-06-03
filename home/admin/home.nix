{ pkgs, ... }:

{
  home.username = "admin";
  home.homeDirectory = "/home/admin";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    git
    neovim
    htop
    btop
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Your Name";
        email = "you@example.com";
      };
    };
  };

  programs.home-manager.enable = true;
}