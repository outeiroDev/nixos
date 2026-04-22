{ config, pkgs, agenix, ... }:

{
  environment.systemPackages = with pkgs; [
    # Hardware-specific
    config.boot.kernelPackages.nvidiaPackages.stable
    egl-wayland

    # Tools
    age
    agenix.packages.${pkgs.system}.default
    wf-recorder

    # Desktop apps
    bibata-cursors
    bitwarden-cli
    bitwarden-desktop
    ghostty
    google-chrome
    inkscape
    legcord
    networkmanagerapplet
    rustdesk
    slack
    spotify
    cacert

    # Editors
    gitbutler
    vscode
    zed-editor

    # Development tools
    fnm
    freeze
    gh
    github-copilot-cli
    pam_u2f
    podman
    podman-compose
    qt5.qtwayland
    skate
    soft-serve
    uv
    vhs
    wireguard-tools
    wishlist

    # Shell tools
    zsh-powerlevel10k
    nix
  ];
}
