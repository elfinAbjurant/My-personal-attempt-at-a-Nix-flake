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

  # Login manager / Hyprland start
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "Hyprland";
        user = "james";
      };
    };
  };

  # System-wide packages
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
  ];

  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerdfonts
    noto-fonts
    noto-fonts-emoji
    noto-fonts-extra
  ];

  # Shell
  programs.zsh.enable = true;

  system.stateVersion = "24.05";
}

