{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ libvdpau-va-gl vaapiVdpau pipewire ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiVdpau libvdpau-va-gl pipewire ];
  };
}
