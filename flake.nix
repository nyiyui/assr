{
  description = "Common NixOS modules";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "systems";
    systems = {
      # https://github.com/nix-systems/nix-systems
      url = "path:./flake.systems.nix";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      systems,
      ...
    }:
    {
      nixosModules = {
        eduroam = import ./eduroam;
        wlsunset = import ./wlsunset;
        displaylink = import ./displaylink.nix;
      };
    }
    // flake-utils.lib.eachSystem (import systems) (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nixfmt
          ];
        };
      }
    );
}
