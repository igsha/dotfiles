{ config, pkgs, ... }:

let
  popup-wcalc = pkgs.writeShellScriptBin "popup-wcalc" ''
    $TERMINAL --class popup -t wcalc -e wcalc
  '';
  popup-translate = pkgs.writeShellScriptBin "popup-translate" ''
    $TERMINAL --class popup -t translate -e trans -I
  '';
  imagePack = with pkgs; [ imv inkscape krita gimp mypaint ];
  pdfPack = with pkgs; [ zathura pdfcpu ghostscript ];
  winePack = with pkgs; [ wineWowPackages.unstable winetricks ];
  mediaPack = with pkgs; [
    ffmpeg-full
    asciinema
    obs-studio
    termplay
    (yt-dlp.override { withAlias = true; })
    v4l-utils
    mpv
  ];
  x11Pack = with pkgs; [ xsel xclip xdotool xorg.xhost hsetroot
    xorg.xev xorg.xkill xfontsel xorg.xwininfo ];
  gstreamerPack = (with pkgs.gst_all_1; [
    gst-plugins-base
    gst-plugins-good
    gst-plugins-bad
    gst-plugins-ugly
    gstreamer
    gstreamer.dev
    gst-libav
  ]);
  officePack = with pkgs; [
    freerdp
    tdesktop
    google-chrome
    wpsoffice
    qutebrowser
    thunderbird
    hunspellDicts.ru-ru
    hunspellDicts.en-us
    rocketchat-desktop
  ];

in {
  users.users = {
    "${config.custom-args.user}" = {
      isNormalUser = true;
      description = "Ordinary user";
      extraGroups = [
        "wheel"
        "disk"
        "audio"
        "cdrom"
        "video"
        "adm"
        "systemd-journal"
        "lp"
        "networkmanager"
        "dialout"
        "docker"
        "input"
      ];
      initialHashedPassword = "root";
      packages = with pkgs; [
        popup-wcalc
        popup-translate
        atool
        bottom
        pavucontrol
        helvum
        ranger
        yad
        libnotify
        fzy
        translate-shell
        metar
        rtorrent
        gitui
        python3Packages.speedtest-cli
        alacritty
        otpclient
        leetcode-cli
      ] ++ imagePack ++ pdfPack ++ winePack ++ mediaPack
      ++ gstreamerPack ++ officePack
      ++ lib.optionals config.services.xserver.enable x11Pack;
    };
  };

  home-config.users = {
    packages = [ "qutebrowser" "alacritty" "mpv" "home-bin" ];
    dir = builtins.toString ./home-config;
  };
}
