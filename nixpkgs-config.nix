{
  nix.useSandbox = true;
  allowUnfree = true;
  virtualbox.host.enableExtensionPack = true;
  firefox.enableAdobeFlash = false;
  chromium.enablePepperFlash = false;
  allowTexliveBuilds = true;
  permittedInsecurePackages = [
    "p7zip-16.02"
    "openssl-1.0.2u"
  ];
  pulseaudio = true;
}
