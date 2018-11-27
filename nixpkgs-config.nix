{
  packageOverrides = let my-packages = /etc/nix-overrides; in
    if builtins.pathExists my-packages
    then import my-packages
    else import (builtins.fetchTarball https://api.github.com/repos/igsha/nix-overrides/tarball/master);
  nix.useSandbox = true;
  allowUnfree = true;
  virtualbox.enableExtensionPack = true;
  firefox.enableAdobeFlash = false;
  chromium.enablePepperFlash = false;
  allowTexliveBuilds = true;
  permittedInsecurePackages = [
    "polipo-1.1.1"
  ];
}
