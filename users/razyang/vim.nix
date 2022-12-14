{ pkgs, ... }:

{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ coc-clangd coc-python coc-rust-analyzer ];
  };
}
