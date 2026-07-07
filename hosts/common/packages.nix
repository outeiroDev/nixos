{ config, pkgs, ... }:

let
  # Override deno to version 2.9.1 using pre-built binary
  deno-2-9 = pkgs.stdenv.mkDerivation rec {
    pname = "deno";
    version = "2.9.1";

    src = pkgs.fetchzip {
      url = "https://github.com/denoland/deno/releases/download/v${version}/deno-x86_64-unknown-linux-gnu.zip";
      sha256 = "sha256-zSIkp/8zvd4t0N2smzQq76Ipug5erldlzV1Y6LwSsPY=";
    };

    dontBuild = true;

    installPhase = ''
      mkdir -p $out/bin
      cp deno $out/bin/deno
      chmod +x $out/bin/deno
    '';

    meta = with pkgs.lib; {
      description = "A secure runtime for JavaScript and TypeScript";
      homepage = "https://deno.land/";
      license = licenses.mit;
      platforms = [ "x86_64-linux" ];
    };
  };
in
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
    act
    deno-2-9
    appimage-run

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
