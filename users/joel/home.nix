{ pkgs, split-monitor-workspaces, ... }:

{
  imports = [
    ./git.nix
  ];

  wayland.windowManager.hyprland.plugins = [
    split-monitor-workspaces.packages."x86_64-linux".split-monitor-workspaces
    pkgs.hyprlandPlugins.hyprexpo
  ];

  home.stateVersion = "25.11";

  # Set Bibata as default cursor theme
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "32";
  };

  home.enableNixpkgsReleaseCheck = false;
  home.username = "joel";
  home.homeDirectory = "/home/joel";
  home.packages = with pkgs; [];

  # Joel's dotfiles
  home.file.".zshrc".source = ./dotfiles/zshrc;
  home.file.".config/ghostty/config".source = ./dotfiles/ghostty;
  xdg.configFile."niri".source = ./dotfiles/niri;
  xdg.configFile."DankMaterialShell".source = ./dotfiles/dms;
  xdg.configFile."hypr".source = ./dotfiles/hypr;

  # SSH public keys (not secrets — plain text is fine)
  home.file.".ssh/joel.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINsqs3rVFAMwaGMbX+AISjIaCBvGx3jWbTj/7viZ377n joel@outeiro.com\n";
  home.file.".ssh/joel_ssb.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFgPE9PEVqu5Ci/phOR0miw2zkFqHuzU32H99pwbCSt8 joelouteiro@sensesbit.com\n";

  # SSH private keys (~/.ssh/joel, ~/.ssh/joel_ssb) are placed manually — not in git or agenix.
  # SSH config is managed by agenix (secrets/default.nix).
}
