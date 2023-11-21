{ config, pkgs, ... }:

let
  custom-lesspipe = pkgs.lesspipe.overrideAttrs (old: {
    postInstall = ''
      for f in lesspipe.sh lesscomplete; do
        wrapProgram "$out/bin/$f" --prefix-each PATH : "${pkgs.lib.makeBinPath (with pkgs; [ file gnused procps binutils ])}"
      done
    '';
  });

in {
  programs = {
    command-not-found.enable = true;
    system-config-printer.enable = true;
    less = {
      enable = true;
      lessopen = "|${custom-lesspipe}/bin/lesspipe.sh %s";
      envVariables = {
        LESS = "-R";
      };
    };
    nix-ld.enable = true;
    fuse.userAllowOther = true;
    starship.enable = true;
    udevil.enable = true;
    adb.enable = true;
    steam.enable = true;
    dconf.enable = true;
  };

  services = {
    dbus.packages = [ pkgs.dconf ];
  };

  nixpkgs.overlays = [
    (final: prev: {
      udevil = prev.udevil.overrideAttrs (old: {
        postInstall = ''
          sed -i 's/^allowed_types =.*/allowed_types = \$KNOWN_FILESYSTEMS, file, cifs, smbfs, nfs, curlftpfs, ftpfs, sshfs, davfs, tmpfs, ramfs/' \
          $out/etc/udevil/udevil.conf
        '';
      });
    })
  ];
}
