{ config, lib, pkgs, ... }:

let
  basedir = builtins.toString ../.;
  update-home-configs = cfg: let
    replaceBaseDir = dir: ''"$BASEDIR${lib.strings.removePrefix basedir dir}"'';
    buildArgs = x: [ "stow" "-v" "--no-folding -d" (replaceBaseDir x.dir) ''-t "$HOME" "$@"'' ] ++ x.packages;
    concater = x: lib.strings.concatStringsSep " " (buildArgs x);
    args = builtins.map concater (builtins.attrValues cfg);
  in pkgs.writeShellApplication {
    name = "update-home-configs";
    runtimeInputs = [ pkgs.stow ];
    text = ''
      ${if lib.strings.isStorePath basedir then ''
        BASEDIR="$1" # ${basedir}
        shift
      '' else ''
        BASEDIR="${basedir}"
      ''}

      ${lib.strings.concatStringsSep "\n" args}
    '';
  };
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
