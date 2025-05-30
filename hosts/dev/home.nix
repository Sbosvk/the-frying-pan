{ config, pkgs, ... } @ args:

let
  conf = import ../../variables.nix;
in

{
  home.username = conf.username;
  home.homeDirectory = conf.homeDirectory;

  # Enable and configure the Git CLI tool
  programs.git.enable = true;

  # Enable the Z shell with default config
  programs.zsh.enable = true;


  # Define packages to be installed for development use
  home.packages = with pkgs; [
    gcc           # C/C++ compiler
    cmake         # C/C++ build tool
    (python3.withPackages (ps: with ps; [ pip venv ]))
    docker        # Docker CLI and daemon
    docker-compose # Docker Compose
    nginx
    letsencrypt
  ];

  # NVM setup: manually install and source it in shell
  home.file.".nvm/install.sh" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh";
      sha256 = "0pr72prvdxcdz694y406ki3gmwj3rpp8rn4s7017rc1w9ak5k0rd";
    };
  };

  # Add NVM initialization to shell
  programs.zsh.initExtra = ''
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  '';

  # Use Studio drivers by default (can be overridden in gaming profile)
  xdg.configFile."nvidia-driver-profile".text = "studio";

  # Required versioning pin: ensures backward-compatible defaults.
  home.stateVersion = "25.05";
}
