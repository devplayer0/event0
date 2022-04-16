{
  # TODO: Properly Nix-ify ZMK
  description = "event0 keyboard";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";
  };

  outputs = { self, nixpkgs, flake-utils, devshell }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      lib = nixpkgs.lib;
      inherit (lib) nameValuePair mapAttrsToList;

      pkgs = import nixpkgs {
        inherit system;

        overlays = [ devshell.overlay ];
      };

    in
    {
      devShells.default = pkgs.devshell.mkShell {
        env = (mapAttrsToList nameValuePair {
          name = "devshell";
        });

        packages = with pkgs; [
          python310Packages.west
        ];

        commands = [];
      };
      devShell = self.devShells.${system}.default;
    });
}
