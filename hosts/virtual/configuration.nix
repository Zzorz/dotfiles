{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules
      ../../modules/bspwm
      ./users/razyang.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  networking.hostName = "virtual";
  time.timeZone = "Asia/Shanghai";

  virtualisation.vmware.guest.enable = true;
  services.openssh.enable = true;
  networking.firewall.enable = false;

  system.stateVersion = "22.11"; # Did you read the comment?
}

