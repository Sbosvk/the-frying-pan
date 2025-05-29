{ config, pkgs, ... } @ args:

let
  conf = import ../../variables.nix;
in

{
  home.username = conf.username;
  home.homeDirectory = conf.homeDirectory;
    # Define packages to be installed for graphical use
  home.packages = with pkgs; [
    inkscape
    gimp3
    davinci-resolve
    ffmpeg
  ];
}
