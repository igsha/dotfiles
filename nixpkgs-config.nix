{
  nix.useSandbox = true;
  allowUnfree = true;
  virtualbox.host.enableExtensionPack = true;
  firefox.enableAdobeFlash = false;
  chromium.enablePepperFlash = false;
  allowTexliveBuilds = true;
  permittedInsecurePackages = [
    "polipo-1.1.1"
  ];
  pulseaudio = true;
}
