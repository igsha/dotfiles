name: { config, pkgs, ... }:

let
  popup-wcalc = pkgs.writeShellScriptBin "popup-wcalc" ''
    $TERMINAL --class popup -t wcalc -e wcalc
  '';
  popup-translate = pkgs.writeShellScriptBin "popup-translate" ''
    $TERMINAL --class popup -t translate -e trans -I
  '';
  reverseNameValuePairs = name: builtins.map (x: pkgs.lib.attrsets.nameValuePair x name);
  reverseMapList = pkgs.lib.attrsets.mapAttrsToList reverseNameValuePairs;
  reverseAttrs = x: builtins.listToAttrs (pkgs.lib.lists.flatten (reverseMapList x));
  listWithPrefix = prefix: builtins.map (x: prefix + x);

in {
  users.users = {
    "${name}" = {
      isNormalUser = true;
      description = "Ordinary user";
      extraGroups = [ "wheel" "disk" "audio" "cdrom" "video" "adm" "systemd-journal" "lp" "networkmanager" "dialout" "docker" "input" ];
      initialHashedPassword = "root";
      packages = with pkgs; [
        popup-wcalc popup-translate
        atool bottom
        wineWowPackages.unstable
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
        yad libnotify slack iplay
        fzy
        asciinema discord obs-studio
        translate-shell
        (yt-dlp.override { withAlias = true; })
        metar rtorrent gitui python3Packages.speedtest-cli pre-commit
        wpsoffice
        termplay
        v4l-utils
        qutebrowser alacritty rofi mpv
        python3Packages.python-gitlab otpclient jitsi-meet-electron
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
    packages = [ "qutebrowser" "alacritty" "rofi" "mpv" "home-bin" ];
    dir = builtins.toString ./home-config;
  };

  xdg.mime = {
    enable = true;
    defaultApplications = reverseAttrs {
      "org.pwmt.zathura.desktop" = listWithPrefix "application/" [ "pdf" "postscript" ];
      "org.qutebrowser.qutebrowser.desktop"  = [ "text/html" ]
        ++ listWithPrefix "x-scheme-handler/" [ "http" "https" ];
      "imv.desktop" = listWithPrefix "image/" [ "png" "jpeg" "jpg" "gif" "vnd.adobe.photoshop" "svg" "heif" ];
      "nvim.desktop" = (listWithPrefix "text/" ([ "plain" "markdown" ] ++ listWithPrefix "x-" [ "cmake" "python" "rst" "makefile" "patch" ]))
        ++ listWithPrefix "application/" [ "json" "octet-stream" "x-yaml" "x-shellscript" "x-wine-extension-ini" "xml" ];
    };
  };
}
