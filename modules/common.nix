{ config, pkgs, lib, ... }:

let
  username = config.custom.username;
  homePath = "/home/${username}";
in
{
  options.custom.username = lib.mkOption {
    type = lib.types.str;
    default = "defaultuser";
    description = "Username used on the system.";
  };

  boot.initrd.luks.devices = {
    home = {
      device = "/dev/disk/by-uuid/4c96db13-b1ab-4c9b-bc85-a2dda35d8d44";
      preLVM = true;
      name = "home_crypt";
    };
  };

  fileSystems."/persist" = {
    device = "/dev/mapper/home_crypt";
    fsType = "ext4";
  };

    environment.persistence."/persist" = {
      directories = [
        "/home"
        "/etc/nixos"
        "/etc/ssh"
        "/var/lib/bluetooth"
        "/etc/NetworkManager"
        "/etc/machine-id"
        "/var/lib/bluetooth"
        "/var/lib/systemd"
        "/var/lib/jellyfin"
      ];
    };

  fileSystems."/media/jelly/Shows" = {
    device = "${homePath}/Torrents/Shows";
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/media/jelly/Movies" = {
    device = "${homePath}/Torrents/Movies";
    fsType = "none";
    options = [ "bind" ];
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "Default User";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "games"];
    shell = pkgs.zsh;
    # openssh.authorizedKeys.keys = [
    #   "ssh-ed25519 AAAA... your_key_here"
    # ];
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
    authorizedKeysFiles = [ "/etc/ssh/authorized_keys.d/%u" ];
  };

  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
  # Essentials
  git
  curl
  wget
  nano
  unzip
  unrar
  htop
  vlc
  firefox
  pavucontrol
  file
  atuin

  # Desktop integration
  xdg-utils
  xdg-desktop-portal

  # Communication
  discord

  # Developer support
  vscode 
];
}