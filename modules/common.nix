{ config, pkgs, ... }:

{
  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";

   # LUKS-encrypted /home
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

  # Audio (example: pipewire)
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # SSH Hardening
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
    authorizedKeysFiles = [ "/etc/ssh/authorized_keys.d/%u" ];
  };

  # Public keys for all users (example user setup)
  # users.users.youruser.openssh.authorizedKeys.keys = [
  #   "ssh-ed25519 AAAA... your_key_here"
  # ];
  
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
    joplin-desktop
  ];

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = false;  # Avoid Wayland due to NVIDIA
}
