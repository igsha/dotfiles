{
  nix.useSandbox = true;
  allowUnfree = true;
  virtualbox.host.enableExtensionPack = true;
  allowTexliveBuilds = true;
  pulseaudio = true;
  android_sdk.accept_license = true;
}
