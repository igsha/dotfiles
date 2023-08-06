{ config, lib, pkgs, ... }:

let
  update-home-configs = cfg: let
    concater = x: lib.strings.concatStringsSep " " ([ "--no-folding -d" x.dir "-t $HOME \"$@\"" ] ++ x.packages);
    args = builtins.map concater (builtins.attrValues cfg);
    calls = lib.strings.concatStringsSep "\n" (builtins.map (x: "${pkgs.stow}/bin/stow -v ${x}") args);
  in pkgs.writeShellScriptBin "update-home-configs" ''
    ${calls}
  '';
  packageOps = {
    options = {
      packages = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "Package names to install";
        example = [ "sx" "vifm" "mpv" ];
      };
      dir = lib.mkOption {
        type = lib.types.str;
        description = "Path to the folder with packages. Should be str type";
        example = builtins.toString ./home-config;
      };
    };
  };

in {
  options.home-config = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule packageOps);
    description = "Package set";
    example = {
      i3 = {
        packages = [ "sx" "vifm" "mpv" ];
        dir = builtins.toString ./home-config;
      };
    };
  };

  config = {
    environment.systemPackages = [
      (update-home-configs config.home-config)
    ];
  };
}
