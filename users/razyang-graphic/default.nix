{pkgs, config, ...}:
{
  imports =  [
    ../razyang
  ];
  home.packages = with pkgs; [
    ghidra-bin
    nitrogen
    google-chrome
    gnome-nautilus
    feh
  ];
  home.pointerCursor = {
    name = "Bibata-Original-Ice";
    package = pkgs.bibata-cursors;
    gtk.enable = true;
    x11.enable = true;
    x11.defaultCursor = "left_ptr";
  };
  gtk = {
    enable = true;
    theme = {
      name = "Breeze";
      package = pkgs.breeze-gtk;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "Noto Sans CJK SC";
      package = pkgs.noto-fonts-cjk-sans;
    };
  };

  xdg.enable = true;

  services.sxhkd.extraConfig = (builtins.readFile ./config/sxhkdrc);
  services.picom = {
    enable = true;
    vSync = true;
  };

  xsession.windowManager.bspwm.startupPrograms = [
    "ibus-daemon -d"
    "xsetroot -cursor_name left_ptr"
    "nitrogen --restore"
  ];

}
