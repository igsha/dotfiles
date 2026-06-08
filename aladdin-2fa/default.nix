{ stdenv, lib, fetchurl, dpkg, autoPatchelfHook, libGL,
libxrandr, libxcursor, libxinerama, libxxf86vm, libxi
}:

stdenv.mkDerivation rec {
  pname = "aladdin-2fa";
  version = "1.3.1.11";
  src = fetchurl {
    url = "https://www.aladdin-rd.ru/upload/downloads/${pname}/${pname}-desktop-x64-${version}.deb";
    hash = "sha256-VYlnvcGAjr+Xc3cFqInaYaUKY2k48FQpWvhDII8UWh0=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    libGL
  ];
  buildInputs = [
    libxrandr
    libxxf86vm
    libxinerama
    libxcursor
    libxi
  ];

  installPhase = ''
    shopt -s extglob
    mkdir -p $out
    cp -r usr/* $out/
    mv $out/sbin $out/bin

    sed -i "s;Exec=/usr/sbin;Exec=$out/bin;g" $out/share/applications/aladdin-2fa-desktop.desktop
  '';

  meta = with lib; {
    description = "Решение для PUSH‑ и OTP‑аутентификации";
    homepage = "https://www.aladdin-rd.ru/catalog/aladdin-2fa/#download";
    maintainers = [ maintainers.igsha ];
    platforms = platforms.linux;
    license = licenses.unfreeRedistributable;
  };
}
