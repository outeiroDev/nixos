# NixOS Configuration

Modular NixOS flake with agenix secrets, niri + hyprland, home-manager.

## Structure

```
flake.nix                         # Entry point
hosts/common/                     # System base — works on any machine
hosts/home/                       # Host "home" (9800X3D + RTX 4070S, WireGuard)
users/joel/                       # Joel's profile (apps, shell, dotfiles)
modules/                          # Opt-in modules (podman, DMS, nix-ld)
secrets/                          # agenix-encrypted .age files
```

## Daily Usage

Everything has a shell alias (defined in `users/joel/shell.nix`):

| Alias | Action |
|-------|--------|
| `update` | `nixos-rebuild switch` |
| `build` | `nixos-rebuild build` (test without applying) |
| `nixos` | `cd /etc/nixos` |
| `epkgs` | Edit packages |
| `eshell` | Edit shell config |
| `ehost` | Edit host config |
| `eflake` | Edit flake |
| `ehome` | Edit home-manager |
| `esrc` | Edit zshrc |
| `esecret` | Edit a secret (e.g. `esecret secrets/users/joel/password.age`) |
| `rekey` | Re-encrypt all secrets after adding a new host key |
| `dotfiles` | `cd` to dotfiles dir |
| `secrets` | `cd` to secrets dir |
| `src` | Reload zshrc |

## Secrets (agenix)

Secrets are age-encrypted `.age` files. Decrypted at boot by `~/.age/key.txt` (passphrase-free age key, never committed).

Joel's SSH pubkey is also in `secrets/secrets.nix` so `agenix -e` works interactively with his SSH key.

| Secret | File |
|--------|------|
| User password | `secrets/users/joel/password.age` |
| U2F auth | `secrets/users/joel/u2f.age` |
| SSH config | `secrets/users/joel/ssh-config.age` |
| WireGuard private key | `secrets/wireguard/private-key.age` |
| WireGuard preshared key | `secrets/wireguard/preshared-key.age` |

SSH private keys (`~/.ssh/joel`, `~/.ssh/joel_ssb`) are placed manually — not managed by agenix or git.

```bash
# Edit a secret (uses your SSH key interactively)
esecret secrets/users/joel/password.age

# Re-encrypt all (after changing keys in secrets.nix)
rekey
```

## Fresh Install

### Prerequisites (files NOT in git — back these up!)

- `~/.age/key.txt` — age identity (master decryption key)
- `~/.ssh/joel` — personal SSH key
- `~/.ssh/joel_ssb` — work SSH key

### Same machine (reinstall)

```bash
# 1. Boot NixOS USB, partition & mount disks to /mnt
# 2. Clone repo
nix-shell -p git
cd /mnt/etc && rm -rf nixos
git clone https://github.com/joelop3/nixos.git && cd nixos

# 3. Update disk UUIDs in hosts/home/hardware.nix (get with: blkid)
nano hosts/home/hardware.nix

# 4. Install
nixos-install --flake .#home
reboot

# 5. After reboot, restore keys
mkdir -p ~/.age ~/.ssh
cp /backup/key.txt ~/.age/key.txt && chmod 600 ~/.age/key.txt
cp /backup/joel ~/.ssh/joel && chmod 600 ~/.ssh/joel
cp /backup/joel_ssb ~/.ssh/joel_ssb && chmod 600 ~/.ssh/joel_ssb

# 6. Rebuild to decrypt secrets
sudo nixos-rebuild switch --flake /etc/nixos
```

### New machine

```bash
# 1. Boot NixOS USB, partition & mount to /mnt
# 2. Generate hardware config
nixos-generate-config --root /mnt

# 3. Clone repo
nix-shell -p git
cd /mnt/etc && rm -rf nixos
git clone https://github.com/joelop3/nixos.git && cd nixos

# 4. Create host dir
mkdir -p hosts/myhost
cp /mnt/etc/nixos/hardware-configuration.nix hosts/myhost/hardware.nix

# 5. Create hosts/myhost/default.nix
cat > hosts/myhost/default.nix << 'EOF'
{ ... }:
{
  imports = [ ../common ./hardware.nix ];
  system.stateVersion = "25.11";
  networking.hostName = "myhost";
}
EOF

# 6. Add host to flake.nix (copy the "home" block, change name + path)
# 7. Install
nixos-install --flake .#myhost
reboot

# 8. After reboot, copy age key and SSH keys from backup
mkdir -p ~/.age ~/.ssh
cp /backup/key.txt ~/.age/key.txt && chmod 600 ~/.age/key.txt
cp /backup/joel ~/.ssh/joel && chmod 600 ~/.ssh/joel

# 9. Rebuild to decrypt secrets
sudo nixos-rebuild switch --flake /etc/nixos
```

## Key Backup Checklist

**Back up these files** — they're needed to decrypt secrets and authenticate:

- `~/.age/key.txt` — master decryption key (agenix uses this at boot)
- `~/.ssh/joel` — personal SSH key
- `~/.ssh/joel_ssb` — work SSH key

