{ nixos-wsl, ... }:

{
  imports = [
    nixos-wsl.nixosModules.default
    {
      wsl = {
        enable = true;
        defaultUser = "isharonov";
      };
    }

    ../../custom-args
    ../../fragments/other
    ../../fragments/packages
    ../../fragments/packages/python-lab
    ../../fragments/programs
    ../../fragments/programs/bash
    ../../fragments/programs/git
    ../../fragments/programs/gnupg
    ../../fragments/programs/neovim
    ../../fragments/programs/tmux
  ];

  networking.hostName = "t490s";
}
