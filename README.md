# NixOS Configuration

Modular NixOS flake with agenix secrets, niri + hyprland, home-manager.

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

- `/etc/nixos/secrets/cloud-password` — password for cloud storage

**Back up these files** — they're needed:

- `~/.ssh/joel` — personal SSH key
- `~/.ssh/joel_ssb` — work SSH key

