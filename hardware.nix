{ pkgs }:

{
  opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau intel-ocl pipewire ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiVdpau libvdpau-va-gl vaapiVdpau pipewire ];
  };

  pulseaudio = {
    enable = true;
    support32Bit = true;
    daemon.config = {
      flat-volumes = "no";
    };
  };
}
