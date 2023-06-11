{ pkgs, inputs, ... }: {
  imports = [
    ../../modules/home
    ../../modules/home/starship
    ../../modules/home/zsh
    ../../modules/home/alacritty
    ../../modules/home/bspwm
    ./vim.nix
    inputs.doom.hmModule
  ];

  programs.git.userName = "RazYang";
  programs.git.userEmail = "xzzorz@gmail.com";

  services.sxhkd.extraConfig = (builtins.readFile ./config/sxhkdrc);
  services.picom = {
    enable = true;
    vSync = true;
  };

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [ tmuxPlugins.nord ];
    extraConfig = (builtins.readFile ./config/tmux.conf);
  };

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./config/doom.d;
  };

  xdg.enable = true;

  home.packages = with pkgs; [
    google-chrome
    ripgrep
    nixfmt
    gnome.nautilus
    fd
    nix-index
    ncdu
    dig
    bottom
    ghidra-bin
    gef
    radare2
    feh
    nitrogen
    file
    iperf3
  ];

  programs.zsh = {
    enable = true;
    plugins = [{
      name = "zinit";
      file = "zinit.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "zdharma-continuum";
        repo = "zinit";
        rev = "v3.8.0";
        sha256 =
          "c8651cc2bc0b5e9b01de7cc62136e2ff4c9c65e8f4f46be8cc3a2c7047fbaa9e";
      };
    }];
    initExtra = (builtins.readFile ./config/zshrc);
  };

  programs.fzf.enable = true;

  xsession.windowManager.bspwm.startupPrograms = [ 
    "xsetroot -cursor_name left_ptr"
    "nitrogen --restore"
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

  home.stateVersion = "22.11";
}
