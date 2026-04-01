{ config, pkgs, ... }:

{
  users.users.greeter = {
    isSystemUser = true;
  };

  users.users.joel = {
    isNormalUser = true;
    description = "joel";
    extraGroups = [ "networkmanager" "wheel" "podman" "joel" "greeter" ];
    shell = pkgs.zsh;
    hashedPasswordFile = config.age.secrets.joel-password.path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINsqs3rVFAMwaGMbX+AISjIaCBvGx3jWbTj/7viZ377n joel@outeiro.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFgPE9PEVqu5Ci/phOR0miw2zkFqHuzU32H99pwbCSt8 joelouteiro@sensesbit.com"
    ];
  };
}
