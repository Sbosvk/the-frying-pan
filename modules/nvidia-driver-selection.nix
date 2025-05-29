{ config, pkgs, lib, ... }:

let
  driverMode = config.custom.nvidiaDriverMode or "studio"; # default
  selectedPackage = if driverMode == "game"
                    then config.boot.kernelPackages.nvidiaPackages.production
                    else config.boot.kernelPackages.nvidiaPackages.studio;
in
{
  options.custom.nvidiaDriverMode = lib.mkOption {
    type = lib.types.str;
    default = "studio";
    description = "NVIDIA driver mode: 'studio' or 'game'";
  };

  config = {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.package = selectedPackage;
  };
}
