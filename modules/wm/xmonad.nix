{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.wm.xmonad;
  xmonad-env = pkgs.haskellPackages.ghcWithHoogle
    (hp: with hp; [ xmobar xmonad xmonad-contrib xmonad-extras ]);

in {
  options.modules.wm.xmonad = { enable = mkEnableOption "xmonad"; };

  config = mkIf cfg.enable {

    services.xserver.displayManager = {
      defaultSession = "none+xmonad";
      lightdm.greeters.mini = {
        enable = false;
        user = "${config.my.username}";
        extraConfig = ''
          [greeter-theme]
          background-image = "";
          background-color = "#0C0F12"
          text-color = "#ff79c6"
          password-background-color = "#1E2029"
          window-color = "#181a23"
          border-color = "#bd93f9"
        '';
      };
    };

    home-manager.users.${config.my.username} = {
      home.packages = [ xmonad-env ];
      # services.caffeine.enable = true;
      services.xscreensaver.enable = true;
      services.betterlockscreen.enable = true;
      services.pasystray.enable = true;
      services.trayer = {
        enable = true;
        settings = {
          edge = "top";
          align = "right";
          SetPartialStrut = true;
          monitor = "1";
          expand = true;
          width = 10;
          transparent = true;
          height = 36;
          SetDockType = true;
          tint = "0x5f5f5f";

        };
      };
      xresources.properties = {
        "Xft.dpi" = 180;
        "Xft.autohint" = 0;
        "Xft.hintstyle" = "hintfull";
        "Xft.hinting" = 1;
        "Xft.antialias" = 1;
        "Xft.rgba" = "rgb";
        "Xcursor*theme" = "Vanilla-DMZ-AA";
        "Xcursor*size" = 24;
      };

      gtk = {
        enable = true;
        theme = {
          name = "dracula-theme";
          package = pkgs.dracula-theme;
        };
      };
      xsession = {
        enable = true;
        windowManager.xmonad = {
          enable = true;
          enableContribAndExtras = true;
          config = ../../xmonad/xmonad.hs;

        };
      };

      programs.xmobar = {
        enable = true;
        extraConfig = ''
          Config { overrideRedirect = False
                 , font     = "xft:iosevka-10"
                 , bgColor  = "#5f5f5f"
                 , fgColor  = "#f8f8f2"
                 , position = TopW L 90
                 , commands = [ Run Weather "EGPF"
                                  [ "--template", "<weather> <tempC>°C"
                                  , "-L", "0"
                                  , "-H", "25"
                                  , "--low"   , "lightblue"
                                  , "--normal", "#f8f8f2"
                                  , "--high"  , "red"
                                  ] 36000
                              , Run Cpu
                                  [ "-L", "3"
                                  , "-H", "50"
                                  , "--high"  , "red"
                                  , "--normal", "green"
                                  ] 10
                              , Run Alsa "default" "Master"
                                  [ "--template", "<volumestatus>"
                                  , "--suffix"  , "True"
                                  , "--"
                                  , "--on", ""
                                  ]
                              , Run Memory ["--template", "Mem: <usedratio>%"] 10
                              , Run Swap [] 10
                              , Run Date "%a %Y-%m-%d <fc=#8be9fd>%H:%M</fc>" "date" 10
                              , Run XMonadLog
                              ]
                 , sepChar  = "%"
                 , alignSep = "}{"
                 , template = "%XMonadLog% }{ %alsa:default:Master% | %cpu% | %memory% * %swap% | %EGPF% | %date% "
                 }
        '';
      };
    };
  };

}
