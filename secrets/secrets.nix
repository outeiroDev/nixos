let
  # Joel's SSH public key — for encrypting/editing secrets interactively (agenix -e).
  joel-ssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINsqs3rVFAMwaGMbX+AISjIaCBvGx3jWbTj/7viZ377n joel@outeiro.com";

  # Age key — for boot-time decryption (no passphrase).
  # Private key at ~/.age/key.txt (never in git, placed manually on each machine).
  joel-age = "age1v0pj7uvxfx0uq68pgnau2trfew0h84pkv7hglpxmd7z757x2y9sq070euh";

  allKeys = [ joel-ssh joel-age ];
in
{
  # User secrets
  "users/joel/password.age".publicKeys = allKeys;
  "users/joel/u2f.age".publicKeys = allKeys;
  "users/joel/ssh-config.age".publicKeys = allKeys;

  # WireGuard secrets
  "wireguard/private-key.age".publicKeys = allKeys;
  "wireguard/preshared-key.age".publicKeys = allKeys;
}
