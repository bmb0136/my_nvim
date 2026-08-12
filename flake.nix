{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
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
          "aarch64-darwin"
        ];
        perSystem =
          {
            self',
            pkgs,
            lib,
            ...
          }:
          let
            allLangs = [
              "angular"
              "arduino"
              "asm"
              "astro"
              "awk"
              #"bash"
              "beancount"
              "clang"
              "clojure"
              "cmake"
              "csharp"
              "css"
              "cue"
              "dart"
              "docker"
              "elixir"
              "elm"
              "env"
              "fish"
              "fluent"
              "fsharp"
              "gettext"
              "gleam"
              "glsl"
              "go"
              "haskell"
              "hcl"
              "helm"
              "html"
              "java"
              "jinja"
              "jq"
              "json"
              "json5"
              "julia"
              "just"
              "kotlin"
              "liquid"
              "lisp"
              "lua"
              "make"
              "markdown"
              "nim"
              #"nix"
              "nu"
              "ocaml"
              "odin"
              "openscad"
              "php"
              "pug"
              "python"
              "qml"
              "query"
              "r"
              "ruby"
              "rust"
              "scala"
              "scss"
              "scss"
              "sql"
              "standard-ml"
              "svelte"
              "tera"
              "terraform"
              "tex"
              "toml"
              "tsx"
              "twig"
              "typescript"
              "typst"
              "vala"
              "vhdl"
              "vue"
              "wgsl"
              "xml"
              "yaml"
              "zig"
              "zsh"
            ];
            perLangConfig = {
              csharp = {
                config.vim.options = {
                  tabstop = lib.mkForce 4;
                  shiftwidth = lib.mkForce 4;
                };
              };
            };
            allConfigs = lib.attrsets.genAttrs allLangs (
              l:
              pkgs.callPackage ./nvim.nix {
                inherit (inputs) nvf;
                "enable-${l}" = true;
                modules = (lib.optional (builtins.hasAttr l perLangConfig) perLangConfig.${l});
              }
            );
          in
          {
            packages = allConfigs // {
              default = pkgs.callPackage ./nvim.nix { inherit (inputs) nvf; };

              # Use this to test that all language configs build
              # WARNING: Downloads ~5GB of deps!
              all = pkgs.symlinkJoin {
                name = "all";
                paths = [
                  self'.packages.default
                ]
                ++ map (
                  l:
                  pkgs.runCommand l
                    {
                      nativeBuildInputs = [ pkgs.makeWrapper ];
                    }
                    ''
                      mkdir -p $out/bin
                      makeWrapper ${self'.packages.${l}}/bin/nvim $out/bin/nvim-${l}
                    ''
                ) allLangs;
              };
            };
          };
      }
    );
}
