{ ... }:

{
  services = {
    dbus.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;
    upower.enable = true;
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
