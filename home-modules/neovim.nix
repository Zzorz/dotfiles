{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      coc-clangd
      coc-sh
      coc-go
      coc-nvim
      coc-toml
      coc-yaml
      coc-html
      coc-pairs
      coc-cmake
      coc-python
      coc-snippets
      coc-diagnostic
      coc-rust-analyzer
      nvim-treesitter.withAllGrammars
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
      nvim-treesitter-context
      nvim-surround
      telescope-nvim
      vim-airline
      which-key-nvim
      gruvbox-nvim
      indent-blankline-nvim
      vim-sneak
      quick-scope
      copilot-vim
      editorconfig-vim
      vim-visual-multi
    ];
    coc = { enable = true; };
    extraConfig = ''
      set relativenumber
      nnoremap ,f <cmd>Telescope find_files<cr>
      nnoremap ,g <cmd>Telescope live_grep<cr>
      nnoremap ,b <cmd>Telescope buffers<cr>
      nnoremap ,c <cmd>Telescope commands<cr>
      let g:qs_highlight_on_keys = ['f', 'F']

      inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)

      nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
      " Manage extensions
      nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
      " Show commands
      nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
      " Find symbol of current document
      nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
      " Search workspace symbols
      nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
      " Do default action for next item
      nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
      " Do default action for previous item
      nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
      " Resume latest coc list
      nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

      function! CheckBackspace() abort
        let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
      endfunction
      inoremap <silent><expr> <Tab>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()

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
