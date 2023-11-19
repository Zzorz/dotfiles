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

  networking = {
    resolvconf.enable = false;
    hostName = "playground"; 
    nameservers = [ "172.16.0.2" ];
    defaultGateway = {
      address = "172.16.0.1";
      interface = "ens18";
    };
    interfaces = {
      ens18 = {
        ipv4.addresses = [
          { address = "172.16.0.110"; prefixLength = 16; }
        ];
      };
    };
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.razyang = {
    isNormalUser = true;
    description = "razyang";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };
  home-manager.users.razyang = import ../../../home/profiles/razyang {inherit inputs pkgs stateVersion;};
  environment.defaultPackages = with pkgs; [
    nixos-generators
  ];


}
