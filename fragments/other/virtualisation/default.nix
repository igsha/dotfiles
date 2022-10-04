{ pkgs, ... }:

{
  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
    };
    libvirtd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    virt-viewer
    virt-manager
  ];
}
