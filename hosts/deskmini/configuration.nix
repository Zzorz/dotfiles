{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules
      ../../bspwm
      ./users/razyang.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "deskmini";
  time.timeZone = "Asia/Shanghai";

  services.openssh.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "22.11"; # Did you read the comment?
}
