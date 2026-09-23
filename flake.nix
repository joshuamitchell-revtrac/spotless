{
  description = "Dev shell for working with Spotless";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/736aa3bec70b944f7a96f7e063d75cccabbf29bc";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config = {};
            overlays = [];
          };
        in
        {
          default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              jdk21
              maven
            ];
          };
        }
      );
    };
}
