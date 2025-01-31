{ pkgs, ... }:

{
  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      rootless.enable = true;
    };
    libvirtd.enable = true;
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    virtiofsd
  ];
}
