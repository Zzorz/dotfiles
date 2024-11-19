{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];
  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    devShmSize = "100%";
    devSize = "100%";
    runSize = "100%";

    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "tcp_bbr" ];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "fq"; # see https://news.ycombinator.com/item?id=14814530
    };

  };
  services.dbus.implementation = "broker";

  security.wrapperDirSize = "100%";

  networking = {
    hostName = "playground";
    useDHCP = true;
  };

  users.users.root.initialHashedPassword = "$y$j9T$.BxY4vIjQZapjGvpFvNJy1$u.Z.DuX4/z8hk81K8otcOILeECVx53IqRMlcKj/ek87";

  environment.memoryAllocator.provider = "mimalloc";
  environment.persistence."/nix/persistent" = {
    hideMounts = true;
    directories = [
      "/root"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };

  #nixpkgs.hostPlatform = {
  #  system = "x86_64-linux";
  #  gcc.arch = "znver2";
  #  gcc.tune = "znver2";
  #};

  environment.systemPackages = with pkgs; [
    linux-manual
    man-pages
    man-pages-posix
  ];
  nix.settings.system-features = [
    "benchmark"
    "big-parallel"
    "kvm"
    "nixos-test"
    "gccarch-znver2"
  ];
  system.stateVersion = "24.05";
}
