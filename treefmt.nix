{
  projectRootFile = "flake.nix";
  programs = {
    nixfmt.enable = true;
    deadnix.enable = true;
    statix.enable = true;
    rumdl-format.enable = true;
    yamlfmt.enable = true;
    clang-format.enable = true;
  };
}
