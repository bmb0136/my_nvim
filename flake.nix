{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} (
      {...}: {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "armv6l-linux"
          "armv7l-linux"
          "i686-linux"
          "aarch64-darwin"
          "powerpc64le-linux"
          "riscv64-linux"
          "x86_64-freebsd"
        ];

        perSystem = { pkgs, inputs, ...}: {
          packages.default =  
            (inputs.nvf.lib.neovimConfiguration {
              inherit pkgs;
              modules = [
                ./common.nix
              ];
            }).neovim;
        };
      }
    );
}
