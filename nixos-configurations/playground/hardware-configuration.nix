{ config, lib, pkgs, modulesPath, ... }:

{

  #boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
  #boot.initrd.kernelModules = [ ];
  #boot.kernelModules = [ "kvm-amd" ];
  #boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=10%" "mode=755" ];
  };

  fileSystems."/nix" = {
	device = "/dev/disk/by-label/NIX";
    fsType = "xfs";
    options = [ "defaults" "size=10%" "mode=755" ];
  };

  fileSystems."/boot" = {
	device = "/dev/disk/by-label/NIX";
    fsType = "vfat";
  };

  fileSystems."/storage" = {
	device = "/dev/disk/by-label/STORAGE";
    fsType = "xfs";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
