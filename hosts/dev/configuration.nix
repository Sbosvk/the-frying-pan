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

  custom.nvidiaDriverMode = "studio";
  services.desktopManager.gnome.enable = true;

  virtualisation.docker.enable = true;

  services.openssh.enable = true;

  system.stateVersion = "25.05";
}
