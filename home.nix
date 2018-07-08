{ pkgs, user, email }:

{
  home.packages = [
    pkgs.atool
  ];

  programs = {
    home-manager.enable = true;
    git = import ./gitConfig.nix { userName = user; userEmail = email; };
    fzf.enable = true;
    pidgin = {
      enable = true;
      plugins = with pkgs; [ pidgin-latex pidgin-osd purple-hangouts telegram-purple pidgin-window-merge ];
    };
  };

  home.file = {
    ".config/matplotlib".source = configs/matplotlib;
    ".config/vifm/vifmrc".source = configs/vifmrc;
    ".config/qutebrowser/config.py".source = configs/qutebrowser/config.py;
    ".config/qutebrowser/scrollbar.css".source = configs/qutebrowser/scrollbar.css;
    ".config/dunst/dunstrc".source = configs/dunstrc;
    ".wcalcrc".source = configs/wcalcrc;
    ".gdbinit".source = configs/gdbinit;
    ".Xdefaults".source = configs/Xdefaults;
    ".git-prompt.sh".source = configs/git-prompt.sh;
    ".bashrc".source = configs/bashrc;
  };
}
