{ lib, pkgs, config, services, ... }: {

  my = {

    username = "yuanwang";
    name = "Yuan Wang";
    email = "yuan.wang@workiva.com";
    hostname = "wf17084";
    gpgKey = "19AD3F6B1A5BF3BF";
    homeDirectory = "/Users/yuanwang";
  };
  home-manager.users.${config.my.username}.programs = {
    go = {
      enable = true;
      goPath = "go";
    };
    git = {
      extraConfig = {
        github.user = "yuanwang-wf";
        url."git@github.com:".insteadOf = "https://github.com";
      };
    };
  };
  modules = {
    brew = {
      enable = true;
      taps = [
        "homebrew/core"
        "homebrew/cask"
        "qmk/qmk"
        "osx-cross/avr"
        "osx-cross/arm"
      ];

      casks = [
        "brave-browser"
        "docker"
        "firefox"
        "google-chrome"
        "qutebrowser"
        "hammerspoon"
        "insomnia"
        "karabiner-elements"
        "stretchly"
      ];
      brews = [ "pyenv" "pngpaste" "avr-gcc" "qmk/qmk/qmk" ];
    };
    browsers.firefox = {
      enable = true;
      pkg = pkgs.runCommand "firefox-0.0.0" { } "mkdir $out";
    };
    editors.emacs = {
      enable = true;
      # enableService = true;
      pkg = pkgs.emacsMacport;
    };

    colemak.enable = true;
    dev = {
      agda.enable = false;
      python.enable = true;
      haskell.enable = true;
      dart.enable = true;
      # node.enable = true;
    };

    terminal = {
      enable = true;
      mainWorkspaceDir = "$HOME/workiva";
    };
    wm.yabai.enable = true;
  };
  programs = { workShell.enable = true; };
}
