{ config, pkgs, ... }:

{
  home.username = "james";
  home.homeDirectory = "/home/james";

  programs.home-manager.enable = true;

  # Extra user packages (optional)
  home.packages = with pkgs; [
    # Add per-user packages here if needed
  ];

  # Alacritty config managed via your repo
  xdg.configFile."alacritty/alacritty.toml".source =
    /home/james/dotfiles/alacritty.toml;

  # GTK theming: auto-apply theme and icons
  gtk = {
    enable = true;

    theme = {
      # Set to the actual GTK theme directory name under /run/current-system/sw/share/themes
      name = "Gruvbox-Dark";
      package = null; # theme package is provided system-wide
    };

    iconTheme = {
      # Set to the actual icon theme name from gruvbox-plus-icons or another icon theme
      name = "Gruvbox-Plus-Dark";
      package = null;
    };

    cursorTheme = {
      name = "Adwaita";
      size = 24;
      package = null;
    };
  };  [web:63]

  # Hyprland config remains a normal file at:
  #   /home/james/.config/hypr/hyprland.conf

  home.stateVersion = "24.05";
}
