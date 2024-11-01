{ inputs, pkgs, ... }:
{
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking = {
    resolvconf.enable = false;
    hostName = "playground";
	useDHCP = true;
	enableIPv6 = true;
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  #programs.zsh.enable
  #users.users.razyang = {
  #  isNormalUser = true;
  #  description = "razyang";
  #  extraGroups = [ "wheel" ];
  #  packages = with pkgs; [ ];
  #  shell = pkgs.zsh;
  #};
  #home-manager.users.razyang = import ../../../home/profiles/razyang { inherit inputs pkgs , stateVersion="24.05"; };
  #environment.defaultPackages = with pkgs; [
  #  nixos-generators
  #];
}
