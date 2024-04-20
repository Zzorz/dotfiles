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

  networking.hostName = "fileserver"; 
  services = {
    redis = {
      servers = {
        "" = {
	  enable=true;
	  bind = null;
	};
      };
    };
    postgresql = {
      enable = true;
      ensureDatabases = ["bitmagnet"];
      dataDir = "/srv/storage/pgsql";
      enableTCPIP = true;
      port = 5432;
        authentication = pkgs.lib.mkOverride 10 ''
    local all      all                          trust
    host  all      all     172.16.0.1/16   trust
    host  all      all     127.16.0.1/32   trust
    host all       all     ::1/128        trust
  '';
    };
    nfs.server = {
      enable = true;
      exports = ''
      /srv/storage 172.16.0.0/16(rw,fsid=1,no_subtree_check)
      '';
    };
    samba = {
      enable = true;
      shares = {
        storage = {
          path = "/srv/storage";
          browseable = "yes";
          "read only" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
        };
      };
    };
    resolved = {
      enable = true;
      llmnr = "false";
      extraConfig = ''
        DNSStubListener=no
        MulticastDNS=false
      '';
      fallbackDns = [
        "172.16.0.2"
      ];
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
