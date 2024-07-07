{ ... }:
{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    colorschemes.gruvbox.enable = true;
    diagnostics.virtual_lines.only_current_line = true;

    ##############################
    ### extra conifigs
    ##############################
    extraConfigLua = ''
      vim.wo.number = true
      vim.wo.relativenumber = true
      vim.o.tabstop = 4
      vim.o.softtabstop = 4
      vim.o.shiftwidth = 4;
    '';

    ##############################
    ### keymaps
    ##############################
    keymaps = [
      {
        key = "vt";
        action = ''<cmd>lua require("flash").treesitter()<cr>'';
        options.desc = "Flash Treesitter selection";
      }
      {
        key = "m";
        action = ''<cmd>MCstart<cr>'';
        options.desc = "Flash Treesitter selection";
      }
      {
        key = "<space><space>";
        action = ''<cmd>Telescope find_files<cr>'';
        options.desc = "Telescope Find File";
      }
      {
        key = "<space>fg";
        action = ''<cmd>Telescope live_grep<cr>'';
        options.desc = "Telescope File Grap";
      }
      {
        key = "<space>s";
        action = ''<cmd>Telescope current_buffer_fuzzy_find<cr>'';
        options.desc = "Telescope buffer Grap";
      }
      {
        key = "<space>b";
        action = ''<cmd>Telescope buffers<cr>'';
        options.desc = "Telescope buffer switch";
      }
    ];


    ##############################
    ### plugins
    ##############################
    plugins = {

      ##############################
      ### notify ui
      ##############################
      notify.enable = true;
      noice = {
        enable = true;
        cmdline.enabled = true;
        presets = {
          bottom_search = true;
          long_message_to_split = true;
          lsp_doc_border = true;
        };
      };


      ##############################
      ### treesitter
      ##############################
      treesitter = {
        enable = true;
        indent = true;
        incrementalSelection = {
          enable = true;
          keymaps = {
            initSelection = "vv";
            nodeIncremental = "e";
            nodeDecremental = "b";
          };
        };
      };
      treesitter-refactor = {
        enable = true;
        highlightCurrentScope.enable = true;
        highlightDefinitions.enable = true;
      };


      ##############################
      ### lsp config
      ##############################
      lsp = {
        enable = true;
        servers = {
          nil-ls.enable = true;
          pyright.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          clangd.enable = true;
          gopls.enable = true;
        };
        keymaps = {
          diagnostic = {
            "[p" = "goto_next";
            "[n" = "goto_prev";
          };
          lspBuf = {
            K = "hover";
            gD = "references";
            gd = "definition";
            gi = "implementation";
            gt = "type_definition";
          };

        };
      };
      trouble.enable = true;
      lspkind.enable = true;

      ##############################
      ### completion
      ##############################
      cmp_luasnip = { enable = true; };
      luasnip = { enable = true; };
      cmp-nvim-lsp = { enable = true; };
      cmp-path = { enable = true; };
      cmp = {
        enable = true;
        settings = {
          indow = {
            completion = { border = "rounded"; };
            documentation = { border = "rounded"; };
          };
          snippet = {
            expand = ''
              function(args)
                require('luasnip').lsp_expand(args.body)
              end
            '';
          };

          completion = {
            completeopt = "menu,menuone,noinsert";
          };
          mapping = {
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<Tab>" = "cmp.mapping.confirm { select = true }";
            "<Enter>" = "cmp.mapping.confirm { select = true }";
          };

          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
          ];
        };
      };

      ##############################
      ### edit
      ##############################
      nvim-autopairs.enable = true;
      surround = { enable = true; };
      indent-blankline.enable = true;
      which-key = { enable = true; window.border = "rounded"; };
      telescope = { enable = true; };
      multicursors = { enable = true; };

      flash = {
        enable = true;
        settings = {
          labels = "abcefghijklmnopqrtuvwxz<>@'";
          label.rainbow = { enabled = true; shade = 9; };
          modes = {
            char = {
              enabled = true;
              jump_labels = true;
              keys = {
                __unkeyed-0 = "f";
                __unkeyed-1 = "F";
                __unkeyed-4 = ";";
                __unkeyed-5 = ",";
              };
            };
            search = { enabled = true; };
            treesitter = {
              enabled = true;
            };
          };
        };
      };

    };
  };
}
