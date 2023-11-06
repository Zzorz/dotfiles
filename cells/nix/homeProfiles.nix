{ inputs, cell }:
let
  inherit (inputs) hive;
in
  hive.findLoad {
    inherit cell;
    inherit inputs;
    block = ./homeProfiles;
  }
