{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      treefmt-nix,
      ...
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forEachSystem = nixpkgs.lib.genAttrs systems;
      perSystem = forEachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
        in
        {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              qmk
            ];
          };
          formatter = treefmtEval.config.build.wrapper;
        }
      );
    in
    {
      devShells = forEachSystem (system: {
        default = perSystem.${system}.devShell;
      });
      formatter = forEachSystem (system: perSystem.${system}.formatter);
    };
}
