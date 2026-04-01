{ pkgs, ... }:

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
}
