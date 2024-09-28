{ pkgs, ... }:

{
  environment = {
    homeBinInPath = true;
    systemPackages = with pkgs; [
      ed
      man stdman man-pages man-pages-posix
      ripgrep
      direnv
      sqlite
      htop atop iotop lsof inetutils
      corkscrew socat wakelan
      tree file which
      openssl
      vifm
      pwgen
      bviplus dhex vbindiff hexyl hecate hexcurse
      universal-ctags
      unrar unzipNLS zip p7zip
      wcalc jq jo yq htmlq
      libxml2
      parallel
      ncdu
      patchutils
      moreutils
      nix-bash-completions bash-completion
      python3Packages.jsbeautifier
      poke
      zx cling
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowTexliveBuilds = true;
      android_sdk.accept_license = true;
      zathura.useMupdf = false;
      permittedInsecurePackages = [
      ];
    };
  };

  home-config.packages = {
    packages = [ "vifm" "wcalc" "gdb" ];
    dir = builtins.toString ./home-config;
  };
}
