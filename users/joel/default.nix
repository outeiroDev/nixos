{ config, pkgs, secrets , ... }:

{
  imports = [
    ./packages.nix
    ./fonts.nix
    ./fonts.nix
    ./shell.nix
  ];
  users.users.greeter = {
    isSystemUser = true;
  };

  users.users.joel = {
    isNormalUser = true;
    description = "joel";
    extraGroups = [ "networkmanager" "wheel" "podman" "joel" "greeter" "root" ];
    shell = pkgs.zsh;
    hashedPasswordFile = "${secrets}/users/joel/password";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINsqs3rVFAMwaGMbX+AISjIaCBvGx3jWbTj/7viZ377n joel@outeiro.com"
    ];
  };
}
