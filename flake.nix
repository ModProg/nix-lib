{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      args = rec {
        inherit nixpkgs;
        inherit (nixpkgs) lib;
        mod = file: (import file) args;
        mpLib = mod src/lib.nix;
      };
    in
    {
      lib = args.mpLib;
    };
}
