_:

{
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  nixpkgs.config.pulseaudio = true;
}
