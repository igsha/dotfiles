{ fetchFromGitHub, python3Packages, writers }:

let
  src = fetchFromGitHub {
    owner = "v1rtuozz";
    repo = "tgwsproxy-openwrt";
    rev = "dac348d8b5f6894a591f74a8389e109cc2e59ce8";
    hash = "sha256-tkxhitSXU4RdqtIUjbaQxGxt7AYp6g1fmqqu2m2u2sI=";
  };

in writers.writePython3Bin "tgwsproxy" {
  libraries = [ python3Packages.cryptography ];
  doCheck = false;
} (builtins.readFile "${src}/tg_ws_proxy.py")
