{ pkgs, ... }:

{
  programs.gnupg.agent = {
    enable = true;
    enableBrowserSocket = true;
    pinentryFlavor = "tty";
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
