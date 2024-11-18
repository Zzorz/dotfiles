{ inputs, pkgsWithSystem }:
{
  "root@playground" = import ./root {
    inherit inputs;
    pkgs = (pkgsWithSystem "x86_64-linux");
  };
  "yang@0xdeadbeef.local" = import ./yang {
    inherit inputs;
    pkgs = (pkgsWithSystem "aarch64-darwin");
  };
}
