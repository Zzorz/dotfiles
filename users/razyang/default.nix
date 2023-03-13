{ pkgs, inputs, ... }: {
  imports = [
    ../common
    ./vim.nix
  ];
  home.username = "razyang";
  home.homeDirectory = "/home/razyang";
 

  programs.git = {
    userName = "RazYang";
    userEmail = "xzzorz@gmail.com";
  };

  home.packages = with pkgs; [
    radare2
  ];
}
