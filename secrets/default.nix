{ config, ... }:

{
  # Passphrase-free age key for boot-time decryption
  age.identityPaths = [ "/home/joel/.age/key.txt" ];

  age.secrets = {
    # User password
    joel-password = {
      file = ./users/joel/password.age;
      owner = "root";
      group = "root";
      mode = "0400";
    };

    # U2F auth
    joel-u2f = {
      file = ./users/joel/u2f.age;
      owner = "root";
      group = "root";
      mode = "0444";
    };

    # SSH config
    joel-ssh-config = {
      file = ./users/joel/ssh-config.age;
      owner = "joel";
      group = "users";
      mode = "0600";
      path = "/home/joel/.ssh/config";
    };

    # WireGuard
    wg-private-key = {
      file = ./wireguard/private-key.age;
      owner = "root";
      group = "root";
      mode = "0400";
    };
    wg-preshared-key = {
      file = ./wireguard/preshared-key.age;
      owner = "root";
      group = "root";
      mode = "0400";
    };
  };
}
