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
      [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
  };

}

