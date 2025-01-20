{ config, pkgs, lib, ... }:

let
  reverseNameValuePairs = name: builtins.map (x: pkgs.lib.attrsets.nameValuePair x name);
  reverseMapList = pkgs.lib.attrsets.mapAttrsToList reverseNameValuePairs;
  reverseAttrs = x: builtins.listToAttrs (pkgs.lib.lists.flatten (reverseMapList x));
  listWithPrefix = prefix: builtins.map (x: prefix + x);

in {
  environment.systemPackages = with pkgs; [
    xdg-utils
    xdg-user-dirs
    xdg-launch
    xdg-ninja
    glib # gio
  ];

  xdg = {
    mime = {
      enable = true;
      defaultApplications = reverseAttrs {
        "org.pwmt.zathura.desktop" = listWithPrefix "application/" [ "pdf" "postscript" ];
        "org.qutebrowser.qutebrowser.desktop"  = [ "text/html" ]
          ++ listWithPrefix "x-scheme-handler/" [ "http" "https" ];
        "imv.desktop" = listWithPrefix "image/" [ "png" "jpeg" "jpg" "vnd.adobe.photoshop" "svg" "heif" ];
        "mpv.desktop" = [ "image/gif" ];
        "nvim.desktop" = (listWithPrefix "text/" ([ "plain" "markdown" ]
            ++ listWithPrefix "x-" [ "cmake" "python" "rst" "makefile" "patch" "readme" "log" ]))
          ++ listWithPrefix "application/" ([ "json" "octet-stream" "xml" ]
            ++ listWithPrefix "x-" [ "yaml" "shellscript" "wine-extension-ini" ]);
      };
    };

    portal = {
      enable = true;
      xdgOpenUsePortal = false;
      wlr.enable = !config.services.xserver.enable;
      config.common.default = "*";
    };

    autostart.enable = true;
  };
}
