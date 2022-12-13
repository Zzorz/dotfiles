{ inputs, ... }:
{
  imports = [
    inputs.doom.hmModule
  ];
  programs.doom-emacs = {
    enable = true;
  };
}
