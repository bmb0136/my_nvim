{
  pkgs,
  nvf,
  modules ? [ ],
  enable-assembly ? false,
  enable-astro ? false,
  enable-bash ? false,
  enable-c ? false,
  enable-cpp ? false,
  enable-clojure ? false,
  enable-csharp ? false,
  enable-css ? false,
  enable-cue ? false,
  enable-dart ? false,
  enable-elixir ? false,
  enable-fsharp ? false,
  enable-gleam ? false,
  enable-go ? false,
  enable-haskell ? false,
  enable-hcl ? false,
  enable-helm ? false,
  enable-html ? false,
  enable-java ? false,
  enable-json ? false,
  enable-julia ? false,
  enable-just ? false,
  enable-kotlin ? false,
  enable-lua ? false,
  enable-markdown ? false,
  enable-nim ? false,
  enable-nu ? false,
  enable-ocaml ? false,
  enable-odin ? false,
  enable-php ? false,
  enable-python ? false,
  enable-qml ? false,
  enable-r ? false,
  enable-ruby ? false,
  enable-rust ? false,
  enable-scala ? false,
  enable-sql ? false,
  enable-svelte ? false,
  enable-tailwind ? false,
  enable-terraform ? false,
  enable-ts ? false,
  enable-typst ? false,
  enable-vala ? false,
  enable-wgsl ? false,
  enable-yaml ? false,
  enable-zig ? false,
  ...
}:
(nvf.lib.neovimConfiguration {
  inherit pkgs;
  modules = modules ++ [
    ./common.nix
    {
      config.vim.languages = {
        assembly.enable = enable-assembly;
        astro.enable = enable-astro;
        bash.enable = enable-bash;
        clang.enable = enable-c || enable-cpp;
        clojure.enable = enable-clojure;
        csharp.enable = enable-csharp;
        css.enable = enable-css;
        cue.enable = enable-cue;
        dart.enable = enable-dart;
        elixir.enable = enable-elixir;
        fsharp.enable = enable-fsharp;
        gleam.enable = enable-gleam;
        go.enable = enable-go;
        haskell.enable = enable-haskell;
        hcl.enable = enable-hcl;
        helm.enable = enable-helm;
        html.enable = enable-html;
        java.enable = enable-java;
        json.enable = enable-json;
        julia.enable = enable-julia;
        just.enable = enable-just;
        kotlin.enable = enable-kotlin;
        lua.enable = enable-lua;
        markdown.enable = enable-markdown;
        nim.enable = enable-nim;
        nu.enable = enable-nu;
        ocaml.enable = enable-ocaml;
        odin.enable = enable-odin;
        php.enable = enable-php;
        python.enable = enable-python;
        qml.enable = enable-qml;
        r.enable = enable-r;
        ruby.enable = enable-ruby;
        rust.enable = enable-rust;
        scala.enable = enable-scala;
        sql.enable = enable-sql;
        svelte.enable = enable-svelte;
        tailwind.enable = enable-tailwind;
        terraform.enable = enable-terraform;
        ts.enable = enable-ts;
        typst.enable = enable-typst;
        vala.enable = enable-vala;
        wgsl.enable = enable-wgsl;
        yaml.enable = enable-yaml;
        zig.enable = enable-zig;
      };
    }
  ]
  ++ modules;
}).neovim
