{ config, pkgs, ... }:

let
  popup-wcalc = pkgs.writeShellScriptBin "popup-wcalc" ''
    $TERMINAL --class popup -t wcalc -e wcalc
  '';
  popup-translate = pkgs.writeShellScriptBin "popup-translate" ''
    $TERMINAL --class popup -t translate -e trans -I
  '';

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
        popup-wcalc popup-translate
        atool bottom
        wineWowPackages.unstable winetricks
        pavucontrol helvum
        imv inkscape krita gimp mypaint
        kpcli
        zathura
        ranger
        ffmpeg-full
        freerdp
        tdesktop
        google-chrome
        hunspellDicts.ru-ru
        hunspellDicts.en-us
        yad libnotify /*iplay*/
        fzy
        asciinema obs-studio
        translate-shell
        (yt-dlp.override { withAlias = true; })
        metar rtorrent gitui python3Packages.speedtest-cli pre-commit
        wpsoffice
        termplay
        v4l-utils
        qutebrowser alacritty mpv
        otpclient
        thunderbird
        rocketchat-desktop
        leetcode-cli
      ] ++ (with gst_all_1; [
        gst-plugins-base
        gst-plugins-good
        gst-plugins-bad
        gst-plugins-ugly
        gstreamer
        gstreamer.dev
        gst-libav
      ]) ++ lib.optionals config.services.xserver.enable [
        xsel xclip xdotool
        xorg.xhost hsetroot xorg.xev xorg.xkill
        xfontsel
        xorg.xwininfo
      ];
    };
  };

  home-config.users = {
    packages = [ "qutebrowser" "alacritty" "mpv" "home-bin" ];
    dir = builtins.toString ./home-config;
  };
}
