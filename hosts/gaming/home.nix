{ config, pkgs, ... } @ args:

let
  conf = import ../../variables.nix;
in

{
  home.username = conf.username;
  home.homeDirectory = conf.homeDirectory;

  # Define packages to be installed for game use
  home.packages = with pkgs; [
    steam
    lutris
    wineWowPackages.staging
    winetricks
    protontricks
    vulkan-tools
    obs-studio
    input-remapper
    mangohud
  ];

  home.stateVersion = "25.05";
}