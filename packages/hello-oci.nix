{pkgs, inputs,system, ...}:
pkgs.dockerTools.buildImage {
  name = "hello-oci";
  tag = "latest";
  copyToRoot = [ inputs.self.packages.${system}.hello ];
  config = {
    Cmd = [ "${inputs.self.packages.${system}.hello}/bin/hello" ];
  };
}
