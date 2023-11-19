{ self, inputs, pkgs, stateVersion, modulesPath, ... }@args:

{
  imports = [
    (import ../../. (args))
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  nixpkgs.hostPlatform = pkgs.lib.mkDefault "x86_64-linux";

  #(modulesPath + "/profiles/docker-container.nix")
  boot.isContainer = true;
  #boot.loader.grub.enable = false;
  #boot.loader.grub.device = "/dev/sda";
  #boot.loader.grub.useOSProber = true;

  networking.hostName = "adguardhome"; 
  services = {
    adguardhome.enable = true;
    resolved = {
      enable = true;
      llmnr = "false";
      extraConfig = ''
        DNSStubListener=no
        MulticastDNS=false
      '';
    };
  };

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
