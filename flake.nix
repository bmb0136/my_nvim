{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nvf = {
      url = "github:NotAShelf/nvf/v0.8";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { self, inputs, ... }:
      {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ];
        perSystem =
          {
            self',
            pkgs,
            ...
          }:
          let
            allLangs = [
              "assembly"
              "astro"
              "c"
              "clojure"
              "cpp"
              "csharp"
              "css"
              "cue"
              "dart"
              "elixir"
              "fsharp"
              "gleam"
              "go"
              "haskell"
              "hcl"
              "helm"
              "html"
              "java"
              "json"
              "julia"
              "just"
              "kotlin"
              "lua"
              "markdown"
              "nim"
              "nu"
              "ocaml"
              "odin"
              "php"
              "python"
              "qml"
              "r"
              "ruby"
              "rust"
              "scala"
              "sql"
              "svelte"
              "tailwind"
              "terraform"
              "ts"
              "typst"
              "vala"
              "wgsl"
              "yaml"
              "zig"
            ];
            allConfigs = pkgs.lib.attrsets.genAttrs allLangs (
              l:
              pkgs.callPackage ./nvim.nix {
                inherit (inputs) nvf;
                "enable-${l}" = true;
              }
            );
          in
          {
            packages = allConfigs // {
              default = pkgs.callPackage ./nvim.nix { inherit (inputs) nvf; };
            };
          };
      }
    );
}
