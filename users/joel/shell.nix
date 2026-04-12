{ pkgs, ... }:

{
  # Joel's opinionated ZSH preferences (layered on top of common/shell.nix basics)
  programs.zsh = {
    shellAliases = {
      # NixOS management
      update = "sudo nixos-rebuild switch --flake /etc/nixos";
      build = "sudo nixos-rebuild build --flake /etc/nixos";
      test-build = "nix build /etc/nixos#nixosConfigurations.home.config.system.build.toplevel --dry-run";

      # Quick edit
      nixos = "cd /etc/nixos/";
      esrc = "$EDITOR /etc/nixos/users/joel/dotfiles/zshrc";
      eflake = "$EDITOR /etc/nixos/flake.nix";
      ehost = "$EDITOR /etc/nixos/hosts/home/default.nix";
      epkgs = "$EDITOR /etc/nixos/users/joel/packages.nix";
      eshell = "$EDITOR /etc/nixos/users/joel/shell.nix";
      ehome = "$EDITOR /etc/nixos/users/joel/home.nix";

      # Secrets
      secrets = "cd /etc/nixos/secrets";
      esecret = "cd $NIXOS_CONFIG && agenix -e";
      rekey = "cd /etc/nixos && agenix -r";

      # Dotfiles
      dotfiles = "cd /etc/nixos/users/joel/dotfiles";

      # Shell
      src = "source ~/.zshrc";
    };
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    ohMyZsh = {
      enable = true;
      plugins = [ "aliases" "zoxide" "eza" "fzf" "gh" "github" "fnm" "ssh-agent" "git" "sudo" "colored-man-pages" "extract" "command-not-found" ];
    };
  };
}
