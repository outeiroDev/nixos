{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    extraModulePackages = [ ];
    kernelModules = [ ];
    kernelParams = [ "nvidia-drm.modeset=1" ];
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "uas" "sd_mod" ];
      kernelModules = [ "kvm-amd" ];
    };
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];


  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ff10adac-1832-4e09-a31b-7283bd363ac6";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/74B8-002D";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/abe143cc-a9d3-433f-80eb-1551356fb4f4"; } ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
