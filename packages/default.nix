{ inputs, pkgs }:
let
  callPackage = file: args: pkgs.callPackage file ({ inherit inputs; } // args);
in
rec {
  test = callPackage ./test { };
  testStatic = callPackage ./test { static = true; };
  nixvim = callPackage ./nixvim.nix { };
  hello = pkgs.hello;
  mongodb = pkgs.mongodb;
  default = hello;
}
