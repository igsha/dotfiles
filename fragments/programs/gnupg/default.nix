{ pkgs, ... }:

{
  programs.gnupg.agent = {
    enable = true;
    enableBrowserSocket = true;
    pinentryPackage = pkgs.pinentry-tty;
  };

  services.passSecretService.enable = true;

  environment.systemPackages = with pkgs; [
    (pass.withExtensions (exts: with exts; [
      pass-otp
      pass-genphrase
    ]))
    zbar
  ];
}
