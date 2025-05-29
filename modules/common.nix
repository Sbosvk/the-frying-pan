{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # Editors & Dev Tools
    vscode
    git
    nano

    # CLI Utilities
    curl
    wget
    htop
    unzip
    unrar
    fzf
    bash-completion
    atuin

    # Media & Communication
    vlc
    discord
    spotify

    # Point-of-life stuff
    brave
  ];

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = false;  # Avoid Wayland due to NVIDIA
}
