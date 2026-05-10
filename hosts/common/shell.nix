{ pkgs, ... }:

{
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  system.userActivationScripts.zshrc = "touch .zshrc";
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
    setOptions = [ "AUTO_CD" ];
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    ohMyZsh = {
      enable = true;
      plugins = [ "aliases" "zoxide" "eza" "fzf" "gh" "github" "fnm" "ssh-agent" "git" "sudo" "colored-man-pages" "extract" "command-not-found" ];
    };
  };
}
