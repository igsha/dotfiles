{ pkgs, ... }:

{
  programs.udevil.enable = true;

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

  system.fsPackages = with pkgs; [
    sshfs
  ];
}
