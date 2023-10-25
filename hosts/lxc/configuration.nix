{ config, pkgs, ... }:

{
  imports = [ ../../modules ];

  networking.hostName = "lxc";
  time.timeZone = "Asia/Shanghai";
  services.openssh.enable = true;
  networking.firewall.enable = false;
  programs.zsh.enable = true;
  i18n.supportedLocales = [ "zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
  #home-manager.users.razyang = import ../../users/razyang;

  system.stateVersion = "23.11"; # Did you read the comment?
}
