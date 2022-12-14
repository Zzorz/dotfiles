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

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [ tmuxPlugins.nord ];
    extraConfig = (builtins.readFile ./config/tmux.conf);
  };

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./config/doom.d;
  };

  home.packages = with pkgs; [ google-chrome ripgrep nixfmt ];
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

  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-rime ];

  xsession.windowManager.bspwm.startupPrograms = [ "fcitx5" ];

  home.stateVersion = "22.11";
}
