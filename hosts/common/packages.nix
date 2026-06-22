{ config, pkgs, ... }:

{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    fnm
    gcc
    zlib
    openssl
    gnumake
    stdenv.cc.cc.lib
  ]; 

  environment.systemPackages = with pkgs; [
    config.boot.kernelPackages.nvidiaPackages.stable
    egl-wayland

    # Tools
    sshfs

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

    # Development tools
    freeze
    gh
    cacert
    github-copilot-cli
    pam_u2f
    podman
    podman-compose
    qt5.qtwayland
    skate
    soft-serve
    vhs
    wireguard-tools
    wishlist
    arduino-ide

    # Shell tools
    zsh-powerlevel10k

    pangolin-cli

    bat
    cliphist
    crush
    dnslookup
    eza
    fzf
    git
    glow
    psmisc
    openssl
    tv
    wl-clipboard
    yazi
    zoxide
  ];
}
