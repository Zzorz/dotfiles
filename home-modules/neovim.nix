{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    colorschemes.gruvbox.enable = true;
    diagnostics.virtual_lines.only_current_line = true;
    plugins = {
      treesitter = {
        enable = true;
        indent = true;
        incrementalSelection = {
          enable = true;
          keymaps = {
            initSelection = "vv";
            nodeDecremental = ",";
            nodeIncremental = "<space>";
          };
        };
      };
      treesitter-context = {
        enable = true;
        settings = {
          enable = true;
          line_numbers = true;
        };
      };
      treesitter-refactor = {
        enable = true;
        highlightCurrentScope.enable = true;
      };
      treesitter-textobjects = {
        enable = true;
      };
      indent-blankline.enable = true;
      surround = { enable = true; };
      multicursors = {
        enable = true;

      };
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
      nvim-autopairs.enable = true;
      trouble.enable = true;
      lspkind.enable = true;
      flash = {
        enable = true;
        settings = {
          labels = "aervhjkiubng<>@'";
          label.rainbow = { enabled = true; shade = 9; };
          modes = {
            char = {
              enabled = true;
              jump_labels = true;
            };
            search = { enabled = true; };
            treesitter = {
              enabled = true;
            };
          };
        };
      };
      which-key = {
        enable = true;
        window.border = "rounded";
      };
      telescope = {
        enable = true;
      };

      noice = {
        enable = true;
        cmdline.enabled = true;
        presets = {
          long_message_to_split = true;
          lsp_doc_border = true;
        };
      };


      cmp_luasnip = { enable = true; };
      luasnip = { enable = true; };
      cmp-nvim-lsp = { enable = true; };
      cmp-path = { enable = true; };
      cmp = {
        enable = true;
        settings = {
          window = {
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
    };
  };
}


