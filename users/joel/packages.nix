{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    slack
    spotify
    gitbutler
    vscode
    zed-editor
    fnm
  ];
}
