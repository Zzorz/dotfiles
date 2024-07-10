{ inputs, system, ... }:
inputs.nixvim.legacyPackages."${system}".makeNixvim {
  viAlias = true;
  vimAlias = true;
  colorschemes.gruvbox.enable = true;
  #diagnostics.virtual_lines.only_current_line = true;

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
      key = "<space>bb";
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
    fidget.enable = true;
    noice = {
      enable = true;
      cmdline.enabled = true;
      popupmenu.backend = "cmp";
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
        bashls.enable = true;
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
          "<space>bf" = "format";
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
        window =
          let
            window_config = {
              border = "rounded";
              scrollbar = false;
            };
          in
          { completion = window_config; documentation = window_config; };
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
    mini = {
      enable = true;
      modules = {
        ai = { };
        surround = { };
        pairs = { };
        starter = { };
      };
    };
    comment.enable = true;
    lualine.enable = true;
    indent-blankline.enable = true;
    which-key = { enable = true; window.border = "rounded"; };
    telescope = { enable = true; };
    multicursors = {
      enable = true;
      normalKeys = {
        "<C-a>".method = false;
        "<C-n>".method = false;
        K.method = false;
        Q.method = false;
        J.method = false;
        q.method = false;
        "[".method = false;
        "]".method = false;
        "{".method = false;
        "}".method = false;
        "Z".method = false;
        m = {
          method = "require('multicursors.normal_mode').find_all_matches";
          opts = { desc = "Find all"; };
        };
      };
      insertKeys = {
        "<C-BS>".method = false;
        "<C-Right>".method = false;
        "<C-Left>".method = false;
        "<Up>".method = false;
        "<Down>".method = false;
        "<A-f>" = { method = "require('multicursors.insert_mode').C_Right"; opts = { desc = "Word forward"; }; };
        "<A-b>" = { method = "require('multicursors.insert_mode').C_Left"; opts = { desc = "Word back"; }; };
        "<C-f>" = { method = "require('multicursors.insert_mode').Right_method"; opts = { desc = "Char forward"; }; };
        "<C-b>" = { method = "require('multicursors.insert_mode').Left_method"; opts = { desc = "Char forward"; }; };
        "<C-a>" = { method = "require('multicursors.insert_mode').Home_method"; opts = { desc = "Head of line"; }; };
        "<C-e>" = { method = "require('multicursors.insert_mode').End_method"; opts = { desc = "End of line"; }; };
      };
      extendKeys = {
        "^".method = false;
        "0" = { method = "require('multicursors.extend_mode').caret_method"; opts = { desc = "Start of line"; }; };
      };
    };

    flash = {
      enable = true;
      settings = {
        labels = "cgjkmnopqrtuvwz<>@'";
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
}
