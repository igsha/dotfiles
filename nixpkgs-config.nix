{
  packageOverrides = import ./packages;
  nix.useSandbox = true;
  allowUnfree = true;
  virtualbox.enableExtensionPack = true;
  firefox.enableAdobeFlash = true;
  chromium.enablePepperFlash = true;
  allowTexliveBuilds = true;
  permittedInsecurePackages = [
    "polipo-1.1.1"
  ];
}
