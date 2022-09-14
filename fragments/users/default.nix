name: { config, pkgs, ... }:

{
  users.users = {
    "${name}" = {
      isNormalUser = true;
      description = "Ordinary user";
      extraGroups = [ "wheel" "disk" "audio" "cdrom" "video" "adm" "systemd-journal" "lp" "networkmanager" "dialout" "docker" "input" ];
      initialHashedPassword = "$6$44A.fbM7DIBXU$qMqdRA82y5NXAQMDLCflWQPWiN2yfkmyEmjYFsia4bvhgnKUJ2e25skNMWlNpk6ILaxNTaNVK7lXcEzCgWffD0";
      packages = with pkgs; [
        atool bottom
        bottles wineWowPackages.unstable
        pavucontrol helvum
        imv inkscape krita gimp mypaint
        kpcli
        zathura
        ranger
        ffmpeg-full
        freerdp
        tdesktop
        google-chrome
        evolutionWithPlugins
        hunspellDicts.ru-ru
        hunspellDicts.en-us
        yad libnotify slack-dark iplay
        fzy
        asciinema discord obs-studio trueconf
        translate-shell
        (yt-dlp.override { withAlias = true; })
        metar rtorrent gitui python3Packages.speedtest-cli pre-commit
        wpsoffice
        termplay
        v4l-utils
        qutebrowser alacritty rofi mpv
      ] ++
      (with gst_all_1; [ gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gstreamer gstreamer.dev gst-libav ]) ++
      lib.optionals config.services.xserver.enable [
        xsel xclip xdotool
        xorg.xhost hsetroot xorg.xev xorg.xkill
        xfontsel
        xorg.xwininfo
      ];
    };
  };

  home-config.users = {
    packages = [ "qutebrowser" "alacritty" "rofi" "mpv" ];
    dir = builtins.toString ./home-config;
  };
}
