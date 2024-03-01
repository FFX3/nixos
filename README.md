# On fresh install hardlink hardware-configuration.nix

``ln /etc/nixos/hardware-configuration.nix .``

# Update system configuration

``sudo nixos-rebuild switch --flake .``

# Test new configuration

``sudo nixos-rebuild test --flake .``

# Update .lock

``nix flake update``

# Update home configuration

``home-manager switch --flake .``
