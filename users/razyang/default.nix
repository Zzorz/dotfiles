{pkgs, ...}:
{
  users.users.razyang = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  home-manager.users.razyang = {
    imports = [
      ../modules/home
      ../modules/home/starship
      ../modules/home/zsh
      ../modules/home/alacritty
      ../modules/home/bspwm
      ./emacs
    ];
    programs.git.userName = "RazYang";
    programs.git.userEmail = "xzzorz@gmail.com";

    programs = {
      chromium.enable = true;
    };
    services.sxhkd.extraConfig = (builtins.readFile ./config/sxhkdrc);
    programs.tmux = {
      enable = true;
      plugins = with pkgs; [
        tmuxPlugins.nord
      ];
      extraConfig = (builtins.readFile ./config/tmux.conf);
    };

    home.stateVersion = "22.11";
  };
  users.users.razyang.shell = pkgs.zsh;
}

