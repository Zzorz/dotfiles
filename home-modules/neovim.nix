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
      nerdcommenter

      nvim-treesitter.withAllGrammars
      nvim-treesitter-refactor
      nvim-treesitter-textobjects

      nvim-treesitter-context

      #copilot-vim

      vim-visual-multi
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      vim-vsnip
      cmp-vsnip
      lspkind-nvim

      trouble-nvim
      {
        plugin = noice-nvim;
        type = "lua";
        config = ''
          require("noice").setup({
            lsp = {
              override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
              },
            },
            presets = {
              bottom_search = false, -- use a classic bottom cmdline for search
              command_palette = true, -- position the cmdline and popupmenu together
              long_message_to_split = true, -- long messages will be sent to a split
              lsp_doc_border = true, -- add a border to hover docs and signature help
            },
	  })
        '';
      }

      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require("nvim-autopairs").setup {}
        '';
      }

      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp');
            cmp.setup({
              snippet = {
              expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
              end,
            },
            formatting = {
              format = function(entry, vim_item) if vim.tbl_contains({ 'path' }, entry.source.name) then
              local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
                  if icon then
                    vim_item.kind = icon
                    vim_item.kind_hl_group = hl_group
                    return vim_item
                  end
                end
                return require('lspkind').cmp_format({ with_text = false })(entry, vim_item)
              end
            },
            window = {
              completion = cmp.config.window.bordered({
                -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                col_offset = -3,
                side_padding = 0,
              }),
              documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
              ['<Tab>'] = cmp.mapping.confirm({ select = true }),
              ['<Enter>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'vsnip' },
            }, {
              { name = 'buffer' },
            })
          })


          cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
          )
        '';
      }

      {
        plugin = lsp-zero-nvim;
        type = "lua";
        config = ''
          local lsp_zero = require('lsp-zero')
          lsp_zero.on_attach(function(client, bufnr)
            lsp_zero.default_keymaps({buffer = bufnr})
          end)
        '';
      }

      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          require('lspconfig').clangd.setup({
            cmd = {"${pkgs.clang-tools}/bin/clangd", "--fallback-style=webkit"},
            capabilities = capabilities,
          })
          require('lspconfig').pyright.setup({
            cmd = {"${pkgs.pyright}/bin/pyright-langserver", "--stdio"},
            capabilities = capabilities,
          })
          require('lspconfig').gopls.setup({
            cmd = {"${pkgs.gopls}/bin/gopls"},
            capabilities = capabilities,
          })
          require('lspconfig').rust_analyzer.setup({
            cmd = {"${pkgs.rust-analyzer}/bin/rust-analyzer"},
            capabilities = capabilities,
          })
          require('lspconfig').nil_ls.setup({
            cmd = {"${pkgs.nil}/bin/nil"},
            capabilities = capabilities,
          })
        '';
      }

      {
        plugin = gruvbox-nvim;
        type = "lua";
        config = ''
          require("gruvbox").setup({
            terminal_colors = true, 
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
              strings = true,
              emphasis = true,
              comments = true,
              operators = false,
              folds = true,
            }, 
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true,
            contrast = "",
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false,
          })
          vim.o.background = "dark" -- or "light" for light mode
          vim.cmd([[colorscheme gruvbox]])
        '';
      }

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
          local highlight = { "CursorColumn", "Whitespace"}
          require("ibl").setup()
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
        plugin = flash-nvim;
        type = "lua";
        config = ''
          local flash = require('flash')
          flash.setup({
            labels = "aervhjkiubng<>@'",
            treesitter = {
              labels = "aervhjkiubng<>@'",
              label = { before = true, after = true, style = "inline" },
            },
            label = {
              rainbow = {
                enabled = true,
                shade = 9,
              },
            },
            modes = {
              search = {
                enable = true,
              },
              char = {
                enable = true,
                jump_labels = true,
                keys = { "f", "F", "," },
              },
            },
          })
          flash.toggle()
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
            p = {
              name = "project",
              a = {"<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", ""},
              d = {"<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", ""},
            },
            e = {
              p = {"<cmd>lua vim.diagnostic.goto_prev()<cr>", ""},
              n = {"<cmd>lua vim.diagnostic.goto_next()<cr>", ""},
              f = {"<cmd>lua vim.diagnostic.open_float()<cr>", ""},
            },
            ["<space>"] = {
              name = "jump",
              f = {"<cmd>lua require('flash').jump()<cr>", "flash jump"},
              t = {"<cmd>lua require('flash').toggle()<cr>", ""},
            }
          }, {prefix= "<space>",noremap = true})
       
          wk.register({
            g = {
              name = "goto",
              D = {"<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration"},
              d = {"<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition"},
              i = {"<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto Implementation"},
              r = {"<cmd>lua vim.lsp.buf.references()<cr>", "Goto Reference"},
            },
            t = {"<cmd>lua require('flash').treesitter() require('flash').toggle()<cr>", ""},
          })
        '';
      }
    ];
    extraConfig = ''
      set relativenumber
    '';
    extraLuaConfig = ''
      vim.o.background = "dark"
      vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
      vim.o.expandtab = true -- Pressing the TAB key ill insert spaces instead of a TAB character
      vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
      vim.o.shiftwidth = 4
      vim.opt.backup = false
      vim.opt.writebackup = false
      vim.opt.updatetime = 300
      vim.opt.signcolumn = "yes"

      function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
    '';
  };
}
