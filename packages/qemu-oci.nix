{
  pkgs,
  inputs,
  system,
  ...
}:
pkgs.dockerTools.buildImage {
  name = "qemu";
  tag = "9.0.0";
  copyToRoot = [
    inputs.self.packages.${system}.qemu
    pkgs.busybox
  ];
}
