{ 
  services.sxhkd.enable = true; 
  xsession.windowManager.bspwm = {
    enable = true;
  };
  xsession.windowManager.bspwm.startupPrograms = [ "alacritty" ];
  programs = {
    rofi.enable = true; 
  };
}
