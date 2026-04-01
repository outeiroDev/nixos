{ ... }:

{
  programs = {
    niri.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    xwayland.enable = true;
  };
}
