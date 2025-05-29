{ config, pkgs, ... }:

let
  vars = import ../../variables.nix;
in
{
  imports = [
    ../../modules/common.nix
    ../../modules/nvidia-driver-selection.nix
  ];

  custom.username = vars.username;

  custom.nvidiaDriverMode = "game";
  services.desktopManager.xfce.enable = true;

  # Enable Steam and required graphics/runtime support
  programs.steam.enable = true;
  hardware.opengl.driSupport32Bit = true;
  programs.gamescope.enable = true;
  security.rtkit.enable = true;  # For better audio/video sync

  # Optional: override steam runtime with extras
  programs.steam.package = pkgs.steam.override {
    extraPkgs = pkgs: with pkgs; [
      vulkan-tools
      libpng
      libpulseaudio
    ];
  };

  # Declare system user using variables
  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "video" "audio" "games" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "25.05";
}
