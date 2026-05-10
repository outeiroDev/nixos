{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-mono
    nerd-fonts.caskaydia-cove
    nerd-fonts.monaspace
  ];
}
