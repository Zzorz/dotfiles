{ pkgs, lib, system, ... }:

{
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings.substituters =
      [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
  };
  environment.systemPackages = [ 
  ];

}
