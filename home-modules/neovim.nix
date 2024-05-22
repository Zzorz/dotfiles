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
              f = {"<cmd>Format<cr>", "format current Buffer"},
            },
            m = {
              name = "multi cursor",
              a = {"<Plug>(VM-Select-All)<Tab>", "Select All"},
              r = {"<Plug>(VM-Start-Regex-Search)", "Start Regex Search"},
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
      vim.opt.backup = false
      vim.opt.writebackup = false
      vim.opt.updatetime = 300
      vim.opt.signcolumn = "yes"

      function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      vim.api.nvim_create_augroup("CocGroup", {})
      vim.api.nvim_create_autocmd("CursorHold", {
        group = "CocGroup",
        command = "silent call CocActionAsync('highlight')",
        desc = "Highlight symbol under cursor on CursorHold"
      })

      local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
      vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})
      vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
      vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(2) : "\<C-h>"]], opts)
      vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
      vim.keymap.set("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
      vim.keymap.set("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})
      vim.keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
      vim.keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
      vim.keymap.set("n", "gd", "<Plug>(coc-definition)", {silent = true})
      vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
      vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", {silent = true})
      vim.keymap.set("n", "gr", "<Plug>(coc-references)", {silent = true})

      vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
    '';
  };
}
