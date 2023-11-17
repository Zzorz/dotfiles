{ self, inputs, pkgs, stateVersion, ... }@args:

{
  imports =
    [ # Include the results of the hardware scan.
      (import ../../. (args))
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "adguardhome"; 

  users.users.razyang = {
    isNormalUser = true;
    description = "razyang";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };
  home-manager.users.razyang = import ../../../home/profiles/razyang {inherit inputs pkgs stateVersion;};
  #razyang {};
  #home-manager.users.razyang = ;

}
