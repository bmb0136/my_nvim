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
      { inputs, ... }:
      {
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
        perSystem =
          { self', pkgs, ... }:
          let
            mkConfig =
              modules:
              (inputs.nvf.lib.neovimConfiguration {
                inherit pkgs;
                modules = [ ./common.nix ] ++ modules;
              }).neovim;
            allLangs = [
              "assembly"
              "astro"
              "bash"
              "cue"
              "dart"
              "clang"
              "clojure"
              "css"
              "elixir"
              "fsharp"
              "gleam"
              "go"
              "hcl"
              "helm"
              "kotlin"
              "html"
              "haskell"
              "java"
              "json"
              "lua"
              "markdown"
              "nim"
              "vala"
              "nix"
              "ocaml"
              "php"
              "python"
              "qml"
              "r"
              "rust"
              "scala"
              "sql"
              "svelte"
              "tailwind"
              "terraform"
              "ts"
              "typst"
              "zig"
              "csharp"
              "julia"
              "nu"
              "odin"
              "wgsl"
              "yaml"
              "ruby"
              "just"
            ];
            allConfigs = pkgs.lib.attrsets.genAttrs allLangs (
              l:
              mkConfig [
                {
                  config.vim.languages.${l}.enable = true;
                }
              ]
            );
          in
          {
            packages = allConfigs // {
              default = mkConfig [ ];
              c = self'.packages.clang;
              cpp = self'.packages.c;
            };
          };
      }
    );
}
