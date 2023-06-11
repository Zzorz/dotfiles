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
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    nerdfonts
  ];
  fonts.fontconfig = {
    enable = true;
    hinting.style = "hintfull";
    defaultFonts = {
      emoji = ["Noto Color Emoji"];
      monospace = ["Hack Nerd Font Mono Hack"];
      sansSerif = ["Noto Sans CJK SC"];
      serif = ["Noto Serif CJK SC"];
    };
  };
}
