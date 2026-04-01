{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
