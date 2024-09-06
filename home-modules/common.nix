{ pkgs, inputs, ... }:
{
  imports = with inputs.self.homeModules; [
    zsh
  ];
  nix.registry = {
    nixpkgs = {
      from = { id = "nixpkgs"; type = "indirect"; };
      flake = inputs.nixpkgs;
    };
    home-manager = {
      from = { id = "home-manager"; type = "indirect"; };
      flake = inputs.home-manager;
    };
    emacs-overlay = {
      from = { id = "emacs-overlay"; type = "indirect"; };
      flake = inputs.emacs-overlay;
    };
  };
  programs = {
    pyenv.enable = true;
    git = {
      userName = "RazYang";
      userEmail = "xzzorz@gmail.com";
    };
    home-manager.enable = true;
    tmux = {
      enable = true;
      escapeTime = 0;
      baseIndex = 1;
      historyLimit = 5000;
      keyMode = "vi";
      prefix = "C-q";
      terminal = "screen-256color";
      plugins = with pkgs.tmuxPlugins; [
        gruvbox
        extrakto
      ];
      extraConfig = ''
        unbind '"'
        unbind %
        bind h split-window -h
        bind v split-window -v
        bind -n M-a select-pane -L
        bind -n M-d select-pane -R
        bind -n M-w select-pane -U
        bind -n M-s select-pane -D
        set-option -g status-position bottom
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      '';
    };
    zoxide = { enable = true; enableZshIntegration = true; };
    fzf = { enable = true; enableZshIntegration = true; };
    command-not-found = {
      enable = true;
      dbPath = inputs.flake-programs-sqlite.packages.${pkgs.system}.programs-sqlite;
    };
    nix-index = {
      enable = true;
      enableZshIntegration = false;
      enableBashIntegration = false;
    };
    atuin = {
      enable = true;
      settings = {
        daemon = {
          enabled = pkgs.system != "aarch64-darwin";
        };
      };
    };
    navi.enable = true;
    ripgrep.enable = true;
    broot.enable = true;
    bottom.enable = true;
    helix =  {
      enable = true;
      settings = {
        theme = "gruvbox_dark_soft";
        editor = {
          line-number = "relative";
          lsp = {
            display-messages = true;
            display-inlay-hints = true;
          };
       };
      };
    };

    lsd = {
      enable = true;
      enableAliases = true;
    };
  };
}
