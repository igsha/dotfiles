{ lib, fetchFromGitHub, python3, wrapGAppsHook3, gobject-introspection }:

# nix shell .#nixosConfigurations.ginnungagap.pkgs.tgwsproxy
python3.pkgs.buildPythonPackage rec {
  pname = "tg-ws-proxy";
  version = "1.10.2";

  pyproject = true;
  src = fetchFromGitHub {
    owner = "Flowseal";
    repo = "tg-ws-proxy";
    rev = "v${version}";
    hash = "sha256-XpO0Hmi0Hotu5TdOZ6+Cg/YBaF31RHJ5MfPJ1JKpPr8=";
  };

  # Make packages versions less strict
  postPatch = ''
    sed -i -E 's/==([0-9])/>=\1/' pyproject.toml
  '';

  nativeBuildInputs = [
    wrapGAppsHook3
    gobject-introspection
  ];

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
    tkinter
    pygobject3
  ];

  meta = with lib; {
    description = "Proxy for telegram";
    maintainers = [ maintainers.igsha ];
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
