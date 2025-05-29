{ config, pkgs, ... }:

{
  boot.initrd.luks.devices = {
    home = {
      device = "/dev/disk/by-uuid/4c96db13-b1ab-4c9b-bc85-a2dda35d8d44";
      preLVM = true;
      name = "home_crypt";
    };
  };

  fileSystems."/home" = {
    device = "/dev/mapper/home_crypt";
    fsType = "ext4";
  };

  fileSystems."/media/plex/Shows" = {
    device = "/home/ardvard/Torrents/Shows";
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/media/plex/Movies" = {
    device = "/home/ardvard/Torrents/Movies";
    fsType = "none";
    options = [ "bind" ];
  };

  users.users.ardvard = {
    isNormalUser = true;
    description = "Default User";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
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
}
