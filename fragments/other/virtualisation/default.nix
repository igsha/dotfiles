{ pkgs, ... }:

{
  virtualisation = {
    containers.registries.settings = {
      registries.search = {
        registries = [ "docker.io" "quay.io" ];
      };
    };
    docker = {
      enable = true;
      autoPrune.enable = true;
      rootless.enable = true;
    };
    libvirtd.enable = true;
    podman.enable = true;
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    virtiofsd
  ];
}
