{inputs, pkgs, ...}:
{
  imports = [ inputs.nix-doom-emacs.hmModule ];
   programs.doom-emacs = {
     enable = true;
     emacsPackage = pkgs.emacs-nox;
     doomPrivateDir = ./doom.d;
   };
}
