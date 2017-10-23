# function to create load environment script with all dependencies
{ pkgs }:

let
  myInteractiveShell = pkgs.bashInteractive.out + pkgs.bashInteractive.shellPath;
in rec {
  createEnv = { name, buildInputs, env ? {} }:
    pkgs.runCommand "my-env-${name}" ({ buildInputs = buildInputs; hardeningDisable = [ "all" ]; } // env)
    ''
      mkdir -p $out/bin
      cat > $out/bin/load-env-${name} <<EOF
      #! ${pkgs.stdenv.shell}
      export NIX_BUILD_SHELL=${myInteractiveShell}
      exec nix-shell \$(nix-store --query --deriver $out)
      # $buildInputs $nativeBuildInputs
      EOF
      chmod +x $out/bin/load-env-${name}
    '';
}
