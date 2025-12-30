{ pkgs, lib, ... }:
{
  config.vim = {
    lsp.enable = true;

    # Get all grammars
    treesitter.grammars = builtins.attrValues (lib.filterAttrs (n: _: lib.strings.hasPrefix "tree-sitter-" n) pkgs.vimPlugins.nvim-treesitter.builtGrammars);

    treesitter = {
      enable = true;
      addDefaultGrammars = true;
      autotagHtml = true;
      context.enable = true;
    };

    languages = {
      enableTreesitter = true;
      enableFormat = true;

      nix = {
        enable = true;
        format.type = [ "nixfmt" ];
      };

      bash.enable = true;
    };

    lsp = {
      formatOnSave = false;
      lspsaga.enable = true;
    };

    autocomplete.nvim-cmp = {
      enable = true;
      mappings = {
        next = "<C-j>";
        previous = "<C-k>";
      };
    };
  };
}
