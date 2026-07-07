{ pkgs, ... }:

{
  services = {
    dbus.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;
    upower.enable = true;
    ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
    };
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        UsePAM = false;
        PermitRootLogin = "no";
      };
    };
    xserver.xkb.layout = "us";
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
