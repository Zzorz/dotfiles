{ inputs, cell }:
{
  username = "root";
  homeDirectory = "/root";
  stateVersion = "23.05";
  packages = with import inputs.nixpkgs {inherit (inputs.nixpkgs) system;}; [
    podman
  ];
}
