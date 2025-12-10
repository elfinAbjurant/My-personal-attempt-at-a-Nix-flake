{ config, pkgs, ... }:

{
  home.username = "james";
  home.homeDirectory = "/home/james";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # extra per-user packages if needed
  ];

  # Alacritty config from repo
  xdg.configFile."alacritty/alacritty.toml".source =
    .config/alacritty/alacritty.toml;

  # Hyprland configs from repo
  xdg.configFile."hypr/hyprland.conf".source =
    .config/hypr/hyprland.conf;

  xdg.configFile."hypr/hyprpaper.conf".source =
    .config/hypr/hyprpaper.conf;

  # Waybar config from repo
  xdg.configFile."waybar/config".source =
    .config/waybar/config;

  xdg.configFile."waybar/style.css".source =
    .config/waybar/style.css;

  # Neovim config from repo
  xdg.configFile."nvim/init.lua".source =
    .config/nvim/init.lua;

  xdg.configFile."nvim/lua/config/plugins.lua".source =
    .config/nvim/lua/config/plugins.lua;

  xdg.configFile."nvim/lua/config/ui.lua".source =
    .config/nvim/lua/config/ui.lua;

  # GTK theming
  gtk = {
    enable = true;

    theme = {
      name = "Gruvbox-Dark";        # adjust to actual theme name
      package = null;
    };

    iconTheme = {
      name = "Gruvbox-Plus-Dark";   # adjust to actual icon theme name
      package = null;
    };

    cursorTheme = {
      name = "Adwaita";
      size = 24;
      package = null;
    };
  };

  # Zsh with rebuild alias (optional)
  programs.zsh = {
    enable = true;
    shellAliases = {
      nrs = "cd /etc/nixos && sudo nixos-rebuild switch --flake .#nixos-hypr";
    };
  };

  home.stateVersion = "24.05";
}
