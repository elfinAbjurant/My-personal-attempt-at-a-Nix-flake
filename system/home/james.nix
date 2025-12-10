{ config, pkgs, ... }:

{
  home.username = "james";
  home.homeDirectory = "/home/james";

  programs.home-manager.enable = true;

  # Extra user packages (optional, most are already system-wide)
  home.packages = with pkgs; [
    # Add per-user packages here if needed
  ];

  # Use your existing Alacritty config file.
  # Adjust this path to where you keep alacritty.toml in your repo.
  xdg.configFile."alacritty/alacritty.toml".source =
    /home/james/dotfiles/alacritty.toml;

  # Hyprland config is kept as a normal file:
  #   /home/james/.config/hypr/hyprland.conf
  # No Hyprland config managed here, so you can edit it freely.

  home.stateVersion = "24.05";
}
