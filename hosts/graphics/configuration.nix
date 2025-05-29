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
  services.desktopManager.pantheon.enable = true;

  environment.systemPackages = with pkgs; [
    pantheon.elementary-settings
    pantheon.switchboard-plug-display
    pantheon.switchboard-plug-useraccounts
  ];

  # Jellyfin
  services.jellyfin = {
    enable = true;
    openFirewall = true;  # Optional: if you want network access
  };

  # Persist data
  environment.persistence."/persist" = {
    directories = [ "/var/lib/jellyfin" ];
  };

  # services.printing.enable = true;         # if printing from graphics apps
  # services.avahi.enable = true;            # for network discovery

  system.stateVersion = "25.05";
}
