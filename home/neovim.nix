{pkgs, ...}:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      coc-clangd
      nvim-treesitter.withAllGrammars
      nvim-surround
      telescope-nvim
      vim-airline
      which-key-nvim
      gruvbox-nvim
      indent-blankline-nvim
      vim-sneak
      quick-scope
    ];
    coc = {
      enable = true;
      settings = {
       languageserver = {
          nix = {
            command = "${pkgs.nil}/bin/nil";
            filetypes = [ "nix" ];
            rootPatterns = [ "flake.nix" ];
            settings = {
             nil = {
                formatting = { command = [ "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt" ]; };
              };
            };
          };

          clangd = {
            command = "${pkgs.clang-tools}/bin/clangd";
            rootPatterns = [ "compile_flags.txt" "compile_commands.json" ];
            filetypes = [ "c" "cc" "cpp" "c++" "objc" "objcpp" "h" "hpp" ];
          };
        };
      };
    };
    extraConfig = ''
    set relativenumber
    nnoremap ,f <cmd>Telescope find_files<cr>
    nnoremap ,g <cmd>Telescope live_grep<cr>
    nnoremap ,b <cmd>Telescope buffers<cr>
    nnoremap ,c <cmd>Telescope commands<cr>
    let g:qs_highlight_on_keys = ['f', 'F']

    let g:indent_guides_enable_on_vim_startup = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:sneak#label = 1
    '';
    extraLuaConfig = ''
    vim.o.background = "dark"
    vim.cmd([[colorscheme gruvbox]])
    require("ibl").setup()
    '';
  };
}
