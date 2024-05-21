{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    withPython3 = true;
    withNodeJs = true;

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
      nerdcommenter
      nvim-treesitter.withAllGrammars
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
      nvim-treesitter-context
      vim-airline
      gruvbox-nvim
      quick-scope
      copilot-vim
      vim-visual-multi
      editorconfig-vim

      { 
        plugin = nvim-surround;
        type = "lua";
        config = ''
          require("nvim-surround").setup()
        '';
      }

      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = ''
          require("ibl").setup()
        '';
      }

      { 
        plugin = vim-easymotion;
        type = "vim";
        config = ''
          wk = require("which-key")
          wk.register({
          },{prefix = "<space>", noremap = true})
        '';
      }
      { 
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local actions = require('telescope.actions')
          require('telescope').setup {
            defaults = {
              mappings = {
                i = {
                  ["<C-j>"] = actions.move_selection_next,
                  ["<C-k>"] = actions.move_selection_previous,
                  ["<C-q>"] = actions.send_to_qflist,
                },
                n = {
                  ["q"] = actions.close,
                  ["<C-g>"] = actions.close,
                },
              },
            },
            pickers = {
              buffers = {
                sort_lastused = true,
                theme = "dropdown",
                previewer = false,
                mappings = {
                  i = {
                    ["<C-d>"] = "delete_buffer",
                  },
                  n = {
                    ["<C-d>"] = "delete_buffer",
                  },
                },
              },
            },

          }
        '';
      }

      {
        plugin = which-key-nvim;
        type = "lua";
        config = ''
          wk = require("which-key")
          wk.setup {
            window = {
              border = "single"
            }
          }
            
          wk.register({
            f = {
              name = "file",
              f = {"<cmd>Telescope find_files<cr>", "Find File"},
              s = {"<cmd>Telescope live_grep<cr>", "Grep File"},
            },
            b = {
              name = "buffer",
              b = {"<cmd>Telescope buffers<cr>", "switch Buffer"},
              s = {"<cmd>Telescope current_buffer_fuzzy_find<cr>", "search in current Buffer"},
            },
            ["<space>"] = {
              name = "easymotion",
              f = {"<Plug>(easymotion-f)", "f{char} to move to {char}"},
              s = {"<Plug>(easymotion-f2)", "s{char}{char} to move to {char}{char}"},
              w = {"<Plug>(easymotion-w)", "Move to word"},
              l = {"<Plug>(easymotion-bd-jk)", "Move to line"},
            }
          }, {prefix= "<space>",noremap = true})

        '';
      }
    ];
    coc = { enable = true; };
    extraConfig = ''
      set relativenumber
    '';
    extraLuaConfig = ''
      vim.o.background = "dark"
      vim.cmd([[colorscheme gruvbox]])
    '';
  };
}
