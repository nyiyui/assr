Collection of NixOS modules I use. Some modules are specific to Georgia Tech, where I am a student, and some are more generally applicable.

Requirements:
- systemd-based system with NetworkManager
- Wayland

Flake outputs:
- `nixosModules`
  - `eduroam` - setup Georgia Tech Eduroam settings using NetworkManager
  - `wlsunset` - "Night Light" for Wayland based on location (provided by GeoClue)
  - `displaylink` - DisplayLink support (some USB-C docks use DisplayLink)
  - `ocproxy` - local SOCKS proxy to Georgia Tech VPN
  - `appliance` - Secure Boot with A/B partitions for updates (like Android)
