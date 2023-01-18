{ pkgs, inputs, ... }: {
  imports = [
    ../../modules/home/zsh
    ./vim.nix
  ];

  programs.git.userName = "RazYang";
  programs.git.userEmail = "xzzorz@gmail.com";

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [ tmuxPlugins.nord ];
    extraConfig = (builtins.readFile ./config/tmux.conf);
  };

  home.packages = with pkgs; [
    starship
    ripgrep
    nixfmt
    fd
    nix-index
    ncdu
    dig
    bottom
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

  home.stateVersion = "22.11";
}
