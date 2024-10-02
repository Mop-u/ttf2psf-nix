{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
        ttf2psf = {
            url = "github:NateChoe1/ttf2psf";
            flake = false;
        };
    };
    outputs = {self,nixpkgs,flake-utils,...} @inputs: flake-utils.lib.eachDefaultSystem (system:
    let
        pkgs = nixpkgs.legacyPackages.${system};
    in{
        packages.ttf2psf = pkgs.stdenv.mkDerivation {
            name = "ttf2psf";
            src = inputs.ttf2psf;
            nativeBuildInputs = with pkgs;[
                freetype
                pkg-config
            ];
            installPhase = ''
                mkdir -p "$out/bin"
                cp "build/ttf2psf" "$out/bin/ttf2psf"
            '';

            system = builtins.currentSystem;

            meta = {
                homepage = "https://github.com/NateChoe1/ttf2psf";
                description = "his just converts files to psf format with freetype, nothing else.";
            };
        };
    });
}