let
  vars = import ../../variables.nix;
in
{
  imports = [
    ../../modules/common.nix
    ../../modules/nvidia-driver-selection.nix
  ];

  custom.nvidiaDriverMode = "studio";
  services.desktopManager.pantheon.enable = true;

  environment.systemPackages = with pkgs; [
    pantheon.elementary-settings
    pantheon.switchboard-plug-display
    pantheon.switchboard-plug-useraccounts
  ];

  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    shell = pkgs.zsh;
  };

  # services.printing.enable = true;         # if printing from graphics apps
  # services.avahi.enable = true;            # for network discovery

  system.stateVersion = "25.05";
}
