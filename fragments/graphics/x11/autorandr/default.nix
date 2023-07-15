{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.autorandr ];

  nixpkgs.overlays = [
    (self: super: {
      autorandr = super.autorandr.overrideAttrs (old: {
        postPatch = ''
          sed -i '/X-GNOME-Autostart-Phase/d' contrib/etc/xdg/autostart/autorandr.desktop
        '';
      });
    })
  ];
}
