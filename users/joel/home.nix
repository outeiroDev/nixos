{ pkgs, ... }:

{
  imports = [
    ./git.nix
  ];

  home.stateVersion = "25.11";
  home.enableNixpkgsReleaseCheck = false;
  home.username = "joel";
  home.homeDirectory = "/home/joel";
  home.packages = with pkgs; [];

  # Joel's dotfiles
  home.file.".zshrc".source = ./dotfiles/zshrc;
  home.file.".config/ghostty/config".source = ./dotfiles/ghostty;
  xdg.configFile."niri".source = ./dotfiles/niri;
  xdg.configFile."DankMaterialShell".source = ./dotfiles/dms;

  # SSH public keys (not secrets — plain text is fine)
  home.file.".ssh/joel.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINsqs3rVFAMwaGMbX+AISjIaCBvGx3jWbTj/7viZ377n joel@outeiro.com";
  home.file.".ssh/joel_ssb.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFgPE9PEVqu5Ci/phOR0miw2zkFqHuzU32H99pwbCSt8 joelouteiro@sensesbit.com";
}
