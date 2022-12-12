{pkgs, ...}:
{
  users.users.razyang = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  home-manager.users.razyang = {
    imports = [
      ../modules/home
      ../modules/home/zoxide
      ../modules/home/starship
      ../modules/home/zsh
      ../modules/home/git
    ];
    programs.git.userName = "RazYang";
    programs.git.userEmail = "xzzorz@gmail.com";

    home.stateVersion = "22.11";
  };
  users.users.razyang.shell = pkgs.zsh;
}