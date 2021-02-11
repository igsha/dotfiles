{
  nix.useSandbox = true;
  allowUnfree = true;
  virtualbox.host.enableExtensionPack = true;
  allowTexliveBuilds = true;
  permittedInsecurePackages = [
    "p7zip-16.02"
    "openssl-1.0.2u"
  ];
  pulseaudio = true;
}
