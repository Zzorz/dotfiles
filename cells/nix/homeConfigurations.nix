{ inputs, cell }: 
let
    bee = {
      inherit (inputs.nixpkgs) system;
      pkgs = import inputs.nixpkgs { inherit (inputs.nixpkgs) system; };
      home = inputs.home-manager;
    };
in
{
  root = {
    inherit bee;
    imports = [
      cell.homeProfiles.root
    ];
  };
}
