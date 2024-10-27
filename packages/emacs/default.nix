{pkgs, ...}:
pkgs.emacs-git-nox
# pkgs.emacsWithPackagesFromUsePackage {
#     package = pkgs.emacs-git-nox;
#     config = ./init.el;
#     defaultInitFile = true;
#     extraEmacsPackages = epkgs: [
#       epkgs.swiper
#       epkgs.ivy
#       epkgs.counsel
#       epkgs.evil
#
#       epkgs.company
#       epkgs.company-quickhelp
#
#       epkgs.gruvbox-theme
#     ];
# }

