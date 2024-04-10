{ pkgs, lib, ... }:

let
  python = pkgs.python3;
  getDeps = x: map (p: "${p}/${p.pythonModule.sitePackages}") x.propagatedBuildInputs;
  toPathWithSep = x: lib.concatStringsSep ":" (getDeps x);
  # Use buildPythonPackage to generate *.pyc files
  yt-dlp-plugins = python.pkgs.buildPythonPackage {
    pname = "yt-dlp-plugins";
    version = "2024.04.09";
    format = "pyproject";
    src = pkgs.fetchFromGitHub {
      owner = "igsha";
      repo = "yt-dlp-plugins";
      rev = "26477534ff5c580da7be50521c619256c0840458";
      hash = "sha256-D8gAoCZObY069aazHDmDrBR6QkdNHK4Xw8qw0w3e9Ic=";
    };
    buildInputs = with python.pkgs; [ setuptools ];
    propagatedBuildInputs = with python.pkgs; [ lxml ];
  };
  yt-dlp-with-plugins = pkgs.symlinkJoin {
    name = "yt-dlp-with-plugins";
    paths = [ pkgs.yt-dlp yt-dlp-plugins ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/yt-dlp \
        --prefix PYTHONPATH : "$out/${python.sitePackages}" \
        --prefix PYTHONPATH : "${toPathWithSep yt-dlp-plugins}"
    '';
  };

in {
  environment.systemPackages = [
    yt-dlp-with-plugins
    # if mpv is used turn off embedded yt-dlp: mpv.override { youtubeSupport = false; };
  ];
}
