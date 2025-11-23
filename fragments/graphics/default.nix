{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ libvdpau-va-gl libva-vdpau-driver pipewire ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva-vdpau-driver libvdpau-va-gl pipewire ];
  };
}
