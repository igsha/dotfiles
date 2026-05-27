{ stdenv, lib, fetchurl, dpkg, autoPatchelfHook, libGL, qt6, qt6Packages, nss, nspr,
libxdamage, libxrandr, alsa-lib, libxshmfence, libnotify, gdk-pixbuf, gtk3, pango,
at-spi2-atk, cairo, glamoroustoolkit, kdePackages, libxv, libfontenc, libxaw, libxcursor,
libxinerama, libxmu, libxpm, libxres, libxscrnsaver, libxt, libxxf86vm, libva, libvdpau,
libxkbfile
}:

stdenv.mkDerivation rec {
  pname = "max";
  version = "26.15.4.69919";
  src = fetchurl {
    url = "https://download.max.ru/linux/deb/pool/main/m/max/MAX-${version}.deb";
    hash = "sha256-esCB30bu/U7jgytC3iG+3ZJppnV/+Fcom5BQmxoUH5c=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    libGL
    qt6.wrapQtAppsHook
  ];
  buildInputs = [
    qt6Packages.qtbase
    nss
    nspr
    libxdamage
    libxrandr
    alsa-lib
    libxshmfence
    libnotify
    gdk-pixbuf
    gtk3
    pango
    at-spi2-atk
    cairo
    glamoroustoolkit
    kdePackages.qtserialport
    libxv
    libfontenc
    libxaw
    libxcursor
    libxinerama
    libxmu
    libxpm
    libxres
    libxscrnsaver
    libxt
    libxxf86vm
    libva
    libvdpau
    libxkbfile
  ];
  installPhase = ''
    mkdir -p $out{,/bin}
    cp -r usr/* $out/
    ln -s $out/share/max/bin/max $out/bin/max
    sed -i "s;/usr/share;$out/share;g" $out/share/applications/max.desktop
  '';

  meta = with lib; {
    description = "An instant messenger from VK";
    homepage = "https://max.ru";
    maintainers = [ maintainers.igsha ];
    platforms = platforms.linux;
    license = licenses.unfreeRedistributable;
  };
}
