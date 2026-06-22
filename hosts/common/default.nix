{ pkgs, secrets, ... }:

{
  imports = [
    ./networking.nix
    ./security.nix
    ./services.nix
    ./desktop.nix
    ./shell.nix
    ./packages.nix
    ./virtualisation.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.autoUpgrade = {
    enable = true;
    dates = "daily";
  };

  programs.fuse.userAllowOther = true;

  time.timeZone = "Europe/Madrid";
  i18n = {
    defaultLocale = "es_ES.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "es_ES.UTF-8";
      LC_IDENTIFICATION = "es_ES.UTF-8";
      LC_MEASUREMENT = "es_ES.UTF-8";
      LC_MONETARY = "es_ES.UTF-8";
      LC_NAME = "es_ES.UTF-8";
      LC_NUMERIC = "es_ES.UTF-8";
      LC_PAPER = "es_ES.UTF-8";
      LC_TELEPHONE = "es_ES.UTF-8";
      LC_TIME = "es_ES.UTF-8";
    };
  };
  
  boot.kernelPackages = pkgs.linuxPackages_latest;


  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.enableAllFirmware = true;

  services.blueman.enable = true;

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 7d";
  nix.settings.auto-optimise-store = true;
}
