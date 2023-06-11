{pkgs, config, ...}:
{
  imports =  [
    ../razyang
  ];
  home.packages = with pkgs; [
    ghidra-bin
    nitrogen
    google-chrome
    rofi
    alacritty
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

  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-rime ];

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  services.sxhkd.extraConfig = (builtins.readFile ./config/sxhkdrc);
  services.sxhkd.enable = true;
  services.picom = {
    enable = true;
    vSync = true;
  };

  xsession.windowManager.bspwm.startupPrograms = [
    "xsetroot -cursor_name left_ptr"
    "nitrogen --restore"
  ];

}
