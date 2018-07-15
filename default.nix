{ pkgs ? import <nixpkgs> { } }:

rec {
  packages = import ./packages { inherit pkgs; };
}
