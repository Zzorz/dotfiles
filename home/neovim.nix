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
      surround
      telescope-nvim
      vim-airline
      which-key-nvim
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
    nnoremap ff <cmd>Telescope find_files<cr>
    nnoremap fg <cmd>Telescope live_grep<cr>
    nnoremap fb <cmd>Telescope buffers<cr>
    nnoremap fc <cmd>Telescope commands<cr>
    '';
    extraLuaConfig = ''
    '';
  };
}
