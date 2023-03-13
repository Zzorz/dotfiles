{ pkgs, inputs, ... }: {
  imports = [
    ../common
  ];
  home.username = "root";
  home.homeDirectory = "/root";


  programs.git.userName = "RazYang";
  programs.git.userEmail = "xzzorz@gmail.com";
  home.packages = with pkgs; [ ];
}
