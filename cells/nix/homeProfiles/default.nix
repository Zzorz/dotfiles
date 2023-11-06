{ inputs, cell }: {
  root = inputs.hive.load {
    inherit inputs cell;
    src = ./root;
  };
}
