{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos-hypr";
  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";

  console.keyMap = "us";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.james = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "input" ];
    shell = pkgs.zsh;
  };

  # Allow sudo for wheel (no password prompt)
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true; 

  # Sound (PipeWire)
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # XDG portal for Wayland / Hyprland
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Default applications (Firefox as default browser)
  xdg.mime.enable = true;
  xdg.mime.defaultApplications = {
    "text/html" = "firefox.desktop";
    "application/xhtml+xml" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };

  # Desktop services
  services.dbus.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # LY display manager (login greeter)
  services.ly = {
    enable = true;
    settings = {
      general = {
        load_command = "exec startx";
      };
    };
  };

  # Ensure Hyprland is available as a session option for LY
  environment.sessionVariables = {
    DISPLAY = ":0";
  };

  # System-wide packages (apps, Hyprland extras, theming tools)
  environment.systemPackages = with pkgs; [
    # core tools
    git
    wget
    curl
    fastfetch

    # requested apps
    alacritty
    libreoffice
    neovim
    rofi-wayland
    firefox
    gruvbox-plus-icons

    # Display Manager
    ly

    # Hyprland-related utilities and look
    waybar          # status bar
    swaync          # notification daemon
    hyprpaper       # wallpaper daemon
    hyprpicker      # color picker
    hyprlock        # lock screen
    nemo            # file manager
    nwg-look        # GTK theme chooser (still handy)
    imagemagick     # useful in many rices
  ];

  # Fonts
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      jetbrains-mono
      noto-fonts
      noto
    ];
  };

  system.stateVersion = "24.05"; # or whatever you used before
}

