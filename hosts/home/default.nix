{ config, pkgs, ... }:

{
  imports = [
    ../common
    ./hardware.nix
    ./networking.nix
    ../../modules/virtualisation.nix
    ../../modules/dms.nix
    ../../modules/nix-ld.nix
  ];

  system.stateVersion = "25.11";
  programs.nano.nanorc = ''
    set linenumbers
    set softwrap
    set tabstospaces
    set tabsize 2
  '';

  # Host-specific PAM / U2F
  security.pam = {
    u2f = {
      enable = true;
      settings.authFile = config.age.secrets.joel-u2f.path;
    };
    services = {
      greetd.u2fAuth = true;
      login.u2fAuth = true;
      sudo.u2fAuth = true;
      sshd.u2fAuth = true;
    };
  };

  # Display manager (host-specific)
  services = {
    desktopManager.plasma6.enable = false;
    displayManager = {
      dms-greeter = {
        enable = true;
        compositor.name = "niri";
        configHome = "/home/joel";
        configFiles = [ "/home/joel/.config/DankMaterialShell/settings.json" ];
        logs = {
          save = true;
          path = "/tmp/dms-greeter.log";
        };
      };
      sddm = {
        enable = false;
        wayland.enable = true;
      };
      sessionPackages = with pkgs; [ niri ];
    };
  };
}
