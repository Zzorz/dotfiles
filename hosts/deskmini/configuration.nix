{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ../../modules ../../modules/bspwm ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "deskmini";
  time.timeZone = "Asia/Shanghai";

  services.xserver.videoDrivers = [ "amdgpu" ];
  services.openssh.enable = true;

  networking.firewall.enable = false;

  users = {
    groups.razyang.gid = 1000;
    users = {
      razyang = {
        uid = 1000;
        isNormalUser = true;
        group = "razyang";
        extraGroups = [ "wheel" ];
        shell = pkgs.zsh;
      };
    };
  };
  programs.zsh.enable = true;
  programs.dconf.enable = true;

  i18n.supportedLocales = [ "zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];


  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ libpinyin rime ];
  };

  home-manager.users.razyang = import ../../users/razyang-graphic;

  system.stateVersion = "23.05"; # Did you read the comment?
}
