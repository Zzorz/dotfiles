{self, inputs, pkgs, stateVersion, ...}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./nix.nix
  ];
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };
  time.timeZone = "Asia/Shanghai";
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
  ];
  programs.zsh.enable = true;
  services.openssh.enable = true;
  users.users.root.shell = pkgs.zsh;
  home-manager.users.root = import ../home/profiles/root {inherit inputs pkgs stateVersion;};
  system.stateVersion = stateVersion;
}
