{ lib, ... }:

{
  options.custom-args = lib.mkOption {
    type = with lib.types; attrsOf anything;
    description = "Arguments for custom submodules.";
  };
}
