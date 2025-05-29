let
  vars = import ../../variables.nix;
in
{
  imports = [
    ../../modules/common.nix
    ../../modules/nvidia-driver-selection.nix
  ];

  custom.nvidiaDriverMode = "studio";
  services.desktopManager.gnome.enable = true;

  virtualisation.docker.enable = true;

  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "docker" "wheel" "networkmanager" "audio" "video" ];
    shell = pkgs.zsh;
  };

  services.openssh.enable = true;

  system.stateVersion = "25.05";
}
