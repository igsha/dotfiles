{ lib, fetchFromGitHub, python3 }:

python3.pkgs.buildPythonPackage rec {
  pname = "tg-ws-proxy";
  version = "1.10.0";

  pyproject = true;
  src = fetchFromGitHub {
    owner = "Flowseal";
    repo = "tg-ws-proxy";
    rev = "v${version}";
    hash = "sha256-ZqOn4ya2jQwwJq4oCI6d0+y4fy1kO4dboWQTAowhuhc=";
  };

  # Make packages version less exact
  postPatch = ''
    sed -i -E 's/==([0-9])/>=\1/' pyproject.toml
  '';

  build-system = with python3.pkgs; [
    setuptools
    hatchling
  ];

  dependencies = with python3.pkgs; [
    pyperclip
    certifi
    psutil
    cryptography
    pillow
    customtkinter
    pystray
  ];

  meta = with lib; {
    description = "Proxy for telegram";
    maintainers = [ maintainers.igsha ];
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
