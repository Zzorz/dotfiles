{ self, inputs, pkgs, stateVersion, modulesPath, ... }@args:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  boot.isContainer = true;

  networking.hostName = "adguardhome";
  services = {
    adguardhome.enable = true;
  };

  #users.users.razyang = {
  #  isNormalUser = true;
  #  description = "razyang";
  #  extraGroups = [ "wheel" ];
  #  packages = with pkgs; [ ];
  #  shell = pkgs.zsh;
  #};
  #home-manager.users.razyang = import ../../../home/profiles/razyang { inherit inputs pkgs stateVersion; };
}
