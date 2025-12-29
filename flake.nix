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
        flake = {
          lib = rec {
            withExtraModules =
              { pkgs, modules }:
              (inputs.nvf.lib.neovimConfiguration {
                inherit pkgs;
                modules = [ ./common.nix ] ++ modules;
              }).neovim;
            withLanguages =
              {
                pkgs,
                langs,
                modules ? [ ],
              }:
              withExtraModules {
                inherit pkgs;
                modules = modules ++ [
                  {
                    config.vim.languages = pkgs.lib.attrsets.genAttrs langs (_: {
                      enable = true;
                    });
                  }
                ];
              };
          };
        };
        perSystem =
          {
            self',
            pkgs,
            ...
          }:
          let
            mkConfig = modules: self.lib.withExtraModules { inherit pkgs modules; };
            allLangs = [
              "assembly"
              "astro"
              "bash"
              "clang"
              "clojure"
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
