{
  pkgs,
  inputs,
  system,
  ...
}:
{
  packages = [
    pkgs.neofetch
  ];
  inputsFrom = [ inputs.self.packages.${system}.qemu ];

}
