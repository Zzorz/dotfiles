{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules
      ../../modules/bspwm
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  networking.hostName = "virtual";
  time.timeZone = "Asia/Shanghai";

  virtualisation.vmware.guest.enable = true;
  services.xserver.videoDrivers = [ "vmware" ];
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
  home-manager.users.razyang = import ../../users/razyang;
  system.stateVersion = "22.11"; # Did you read the comment?
}

