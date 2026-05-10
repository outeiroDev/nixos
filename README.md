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
| `dotfiles` | `cd` to dotfiles dir |
| `secrets` | `cd` to secrets dir |
| `src` | Reload zshrc |

## Fresh Install

### Prerequisites (files NOT in git — back these up!)

- `~/.ssh/joel` — personal SSH key

### Same machine (reinstall)

```bash
# 1. Boot NixOS USB, partition & mount disks to /mnt
# 2. Clone repo
nix-shell -p git
cd /mnt/etc && rm -rf nixos
git clone https://github.com/outeiroDev/nixos.git && cd nixos

# 3. Update disk UUIDs in hosts/home/hardware.nix (get with: blkid)
nano hosts/home/hardware.nix

# 4. Install
nixos-install --flake .#home
reboot


# 5. Rebuild to decrypt secrets
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

# 8. Rebuild to decrypt secrets
sudo nixos-rebuild switch --flake /etc/nixos
```

## Key Backup Checklist

**Back up these files** — they're needed to decrypt secrets and authenticate:

- `/etc/nixos/smb.secret`
- `~/.ssh/joel` — personal SSH key
- `~/.ssh/joel_ssb` — work SSH key

