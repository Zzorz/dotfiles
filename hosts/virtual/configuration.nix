{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules
      ./users/razyang.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  networking.hostName = "0xdeadbeef";
  time.timeZone = "Asia/Shanghai";

  services.openssh.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "22.11"; # Did you read the comment?
}

