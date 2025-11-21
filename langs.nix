{...}: {
  config.vim = {
    lsp.enable = true;

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
        format.type = "nixfmt";
      };
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
