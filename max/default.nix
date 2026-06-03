{ stdenv, lib, fetchurl, dpkg, autoPatchelfHook, libGL, qt6, qt6Packages, nss, nspr,
libxdamage, libxrandr, alsa-lib, libxshmfence, libnotify, gdk-pixbuf, gtk3, pango,
at-spi2-atk, cairo, glamoroustoolkit, libxv, libfontenc, libxaw, libxcursor, pipewire,
libxinerama, libxmu, libxpm, libxres, libxscrnsaver, libxt, libxxf86vm, libva, libvdpau,
libxkbfile, glib, ffmpeg_7, libasyncns, util-linux, dbus, nettle, libsm,
libselinux, libsndfile, libvpl, libtasn1, libunistring, libvorbis, zstd, libz, libxcb-cursor
}:

stdenv.mkDerivation rec {
  pname = "max";
  version = "26.15.5.71245";
  src = fetchurl {
    url = "https://download.max.ru/linux/deb/pool/main/m/max/MAX-${version}.deb";
    hash = "sha256-8P0Es+mahzWf9Qd6wXk7t20B1qMMFS0dT6u697CNzrU=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    libGL
    qt6.wrapQtAppsHook
  ];
  buildInputs = [
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
    ffmpeg_7
    libasyncns
    util-linux
    dbus
    nettle
    libsm
    libselinux
    libsndfile
    libvpl
    libtasn1
    libunistring
    libvorbis
    zstd
    libz
    libxcb-cursor
    glib
    pipewire
  ] ++ (with qt6Packages; [
    qtbase
    qtdeclarative
    qtserialport
    qtmultimedia
    qtwebengine
    qtwebview
    qtpositioning
    qtlottie
  ]);
  runtimeDependencies = [
    glib
  ];

  installPhase = ''
    shopt -s extglob
    mkdir -p $out
    cp -r usr/* $out/
    mv $out/share/max/* $out/

    rm -r $out/lib $out/bin/max-service
    for __FOLDER in $out/lib64/; do
      find "$__FOLDER" \( -type f -o -type l \) \
        ! -name 'lib*_utils.so' \
        ! -name 'libcall*.so' \
        ! -name libconfig.so \
        ! -name libcore.so \
        ! -name 'libfile*.so' \
        ! -name libtracernative.so \
        ! -name libdynamic_library.so \
        ! -name liblogger.so \
        ! -name libnetwork.so \
        ! -name libnotifications.so \
        ! -name libstorage.so \
        ! -name liburl_parser.so \
        ! -name libtracer_crash_reporter.so \
        ! -name libupdater_oneme.so \
        ! -name libweb_apps.so \
        ! -name libEnhancementLibShared.so \
        ! -name 'libonnxruntime.so*' \
        -delete
    done

    sed -i \
      -e "s;Icon=.*/max.png;Icon=$out/share/pixmaps/max.png;g" \
      -e "s;Exec=.*;Exec=$out/bin/max %U;g" \
      $out/share/applications/max.desktop
  '';

  postFixup = ''
    patchelf --replace-needed libQt6Bodymovin.so.6 libQt6Lottie.so.6 $out/qml/Qt/labs/lottieqt/liblottieqtplugin.so
  '';

  meta = with lib; {
    description = "An instant messenger from VK";
    homepage = "https://max.ru";
    maintainers = [ maintainers.igsha ];
    platforms = platforms.linux;
    license = licenses.unfreeRedistributable;
  };
}
