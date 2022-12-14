{pkgs, ...}:

{
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    windowManager.bspwm.enable = true;
    excludePackages = [ pkgs.xterm ];
  };
  fonts.fonts = with pkgs; [
    sarasa-gothic
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    hack-font
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = ["Noto Color Emoji"];
      monospace = ["Hack"];
      sansSerif = ["Noto Sans CJK SC"];
      serif = ["Noto Serif CJK SC"];
    };
  };
}
