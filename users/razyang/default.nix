{ pkgs, inputs, ... }: {
  imports = [
    ../common
  ];
  home.username = "razyang";
  home.homeDirectory = "/home/razyang";
 

  programs.git = {
    userName = "RazYang";
    userEmail = "xzzorz@gmail.com";
  };

  home.packages = with pkgs; [
    #podman
  ];
}
