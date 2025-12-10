{ config, pkgs, hyprland, ... }:

{
  home.username = "james";
  home.homeDirectory = "/home/james";

  programs.home-manager.enable = true;

  # Terminal, editor, etc.
  home.packages = with pkgs; [
    neovim
    alacritty
  ];

  # Put your Hyprland config file under Home Manager control if you want, or just
  # let it manage the directory and keep the raw config file. [web:39][web:37]
  xdg.configFile."hypr/hyprland.conf".text = ''
  xdg.configFile."hypr/hyprland.conf".source =
    /home/james/.config/dotfiles/hyprland.conf;

  # Alacritty config from your existing file:
  xdg.configFile."alacritty/alacritty.toml".source =
    /home/james/.config/dotfiles/alacritty.toml;

  # Optionally use Home Manager's Hyprland module instead of a raw file. [web:39][web:31]
  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   package = hyprland.packages.${pkgs.system}.hyprland;
  #   extraConfig = ''
  #     # extra Hyprland config here
  #   '';
  # };

  home.stateVersion = "24.05";
}
