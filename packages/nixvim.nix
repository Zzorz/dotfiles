{
  inputs,
  pkgs,
  system,
  ...
}:
inputs.nixvim.legacyPackages."${system}".makeNixvim {
  viAlias = true;
  vimAlias = true;
  clipboard.providers = {
    xsel.enable = true;
  };

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
      key = "<space>u";
      action = ''<cmd>Telescope undo<cr>'';
      options.desc = "Telescope undo";
    }
    {
      key = "<space>bb";
      action = ''<cmd>Telescope buffers<cr>'';
      options.desc = "Telescope buffer switch";
    }
    {
      key = "<space>bs";
      action = ''<cmd>Trouble symbols toggle<cr>'';
      options.desc = "Trouble symbols toggle";
    }
    {
      key = "<space>ca";
      action = ''<cmd>lua vim.lsp.buf.code_action()<CR>'';
      options.desc = "Telescope buffer switch";
    }
    {
      key = "<Tab>";
      action.__raw = ''
        function()
          if vim.snippet.active({direction=1}) then
            vim.schedule(function() vim.snippet.jump(1) end)
          return
          end
        end
      '';
    }
    {
      key = "<S-Tab>";
      action.__raw = ''
        function()
          if vim.snippet.active({direction=-1}) then
            vim.schedule(function() vim.snippet.jump(-1) end)
          return
          end
        end
      '';
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
      presets = {
        bottom_search = true;
        long_message_to_split = true;
        lsp_doc_border = true;
      };
    };
    web-devicons.enable = true;

    ##############################
    ### treesitter
    ##############################
    treesitter = {
      enable = true;
      nixGrammars = true;
      nixvimInjections = true;
      settings = {
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "vv";
            node_incremental = "e";
            node_decremental = "b";
            scope_incremental = "E";
          };
        };
      };
    };
    # treesitter-refactor = {
    #   enable = true;
    #   #highlightCurrentScope.enable = true;
    #   highlightDefinitions.enable = true;
    # };
    #treesitter-context.enable = true;

    ##############################
    ### lsp config
    ##############################
    lsp = {
      enable = true;
      capabilities = "require('cmp_nvim_lsp').default_capabilities()";
      inlayHints = true;
      servers = {
        bashls.enable = true;
        nil_ls.enable = true;
        pyright.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        clangd.enable = true;
        gopls.enable = true;
        cmake.enable = true;
        yamlls.enable = true;
        jsonls.enable = true;
        denols.enable = true;
        marksman.enable = true;
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

    # [ https://github.com/folke/trouble.nvim ]
    # A pretty diagnostics list to help you solve all the trouble your code is causing.
    trouble.enable = true;

    # [ https://github.com/onsails/lspkind.nvim ]
    # The plugin adds vscode-like icons to Neovim LSP completions.
    lspkind = {
      enable = true;
      symbolMap = {
        Copilot = "";
      };
    };

    ##############################
    ### completion
    ##############################
    cmp-nvim-lsp = {
      enable = true;
    };
    cmp-path = {
      enable = true;
    };
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
          {
            completion = window_config;
            documentation = window_config;
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
          { name = "copilot"; }
          { name = "nvim_lsp"; }
          { name = "path"; }
        ];
      };
    };

    copilot-lua = {
      enable = true;
      panel.enabled = false;
      suggestion.enabled = false;
      # suggestion = {
      #   autoTrigger = true;
      #   keymap.accept = "<Enter>";
      # };
    };
    copilot-cmp = {
      enable = true;
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
        cursorword = { };
      };
    };
    lualine.enable = true;
    comment.enable = true;
    which-key = {
      enable = true;
      settings.win.border = "rounded";
    };
    telescope = {
      enable = true;
      enabledExtensions = [ "ui-select" ];
      extensions = {
        undo = {
          enable = true;
        };
        ui-select = {
          enable = true;
        };
      };
    };
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
          opts = {
            desc = "Find all";
          };
        };
      };
      insertKeys = {
        "<C-BS>".method = false;
        "<C-Right>".method = false;
        "<C-Left>".method = false;
        "<Up>".method = false;
        "<Down>".method = false;
        "<A-f>" = {
          method = "require('multicursors.insert_mode').C_Right";
          opts = {
            desc = "Word forward";
          };
        };
        "<A-b>" = {
          method = "require('multicursors.insert_mode').C_Left";
          opts = {
            desc = "Word back";
          };
        };
        "<C-f>" = {
          method = "require('multicursors.insert_mode').Right_method";
          opts = {
            desc = "Char forward";
          };
        };
        "<C-b>" = {
          method = "require('multicursors.insert_mode').Left_method";
          opts = {
            desc = "Char forward";
          };
        };
        "<C-a>" = {
          method = "require('multicursors.insert_mode').Home_method";
          opts = {
            desc = "Head of line";
          };
        };
        "<C-e>" = {
          method = "require('multicursors.insert_mode').End_method";
          opts = {
            desc = "End of line";
          };
        };
      };
      extendKeys = {
        "^".method = false;
        "0" = {
          method = "require('multicursors.extend_mode').caret_method";
          opts = {
            desc = "Start of line";
          };
        };
      };
    };

    flash = {
      enable = true;
      settings = {
        labels = "cgjkmnopqrtuvwz<>@'";
        label.rainbow = {
          enabled = true;
          shade = 9;
        };
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
          search = {
            enabled = true;
          };
          treesitter = {
            enabled = true;
          };
        };
      };
    };

    # [ https://github.com/rafamadriz/friendly-snippets ]
    # Set of preconfigured snippets for different languages.
    friendly-snippets.enable = true;
  };
  ##############################
  ### extra plugins
  ##############################
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "hlchunk";
      src = pkgs.fetchFromGitHub {
        owner = "shellRaining";
        repo = "hlchunk.nvim";
        rev = "v1.3.0";
        hash = "sha256-UGxrfFuLJETL/KJNY9k4zehxb6RrXC6UZxnG+7c9JXw=";
      };
    })
    (pkgs.vimUtils.buildVimPlugin {
      name = "nvim-snippets";
      src = pkgs.fetchFromGitHub {
        owner = "garymjr";
        repo = "nvim-snippets";
        rev = "v1.0.0";
        hash = "sha256-1/XgOCTFxFp72WkAMe3MkGcWjSw/xJ7OJvqiN/qT5RE=";
      };
    })
    pkgs.vimPlugins.tabout-nvim
    pkgs.vimPlugins.nvim-highlight-colors
    pkgs.vimPlugins.gruvbox-baby
    pkgs.vimPlugins.guess-indent-nvim
  ];
  ##############################
  ### extra conifigs
  ##############################
  extraConfigLuaPost = ''
    vim.wo.number = true
    vim.wo.relativenumber = true
    vim.o.tabstop = 4
    vim.o.softtabstop = 4
    vim.o.shiftwidth = 4
    vim.opt.termguicolors = true

    require('hlchunk').setup({
      chunk = {
        enable = true,
        use_treesitter = false,
        duration = 50,
        delay = 10,
        chars = {
          right_arrow = "",
        },
        style = "#f88800",
      },
      line_num = {
        enable = true,
        use_treesitter = false,
        style = "#f88800",
      },
    })

    require('snippets').setup()

    require('tabout').setup({
      tabkey = '<Tab>',
      backwards_tabkey = '<S-Tab>',
      ignore_beginning = true,
    })

    require('nvim-highlight-colors').setup({})
    require('guess-indent').setup({})

    vim.g.gruvbox_baby_telescope_theme = 1
    vim.g.gruvbox_baby_background_color = "dark"
    vim.cmd[[colorscheme gruvbox-baby]]
  '';
  extraConfigVim = ''
    set fileencodings=utf-8,gbk,gb18030,gb2312,ucs-bom,cp936,big5,euc-jp,euc-kr
  '';
}
