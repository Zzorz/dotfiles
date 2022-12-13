{
    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "amdgpu" ];
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.windowManager.bspwm.enable = true;
}
