{ pkgs ? import <nixpkgs> { } }:

rec {
  langenv = import ./nixpkgs/langenv.nix { inherit pkgs; };
}
