{ ... }:
{
  config.vim = {
    filetree.neo-tree.enable = true;
    keymaps = [
      {
        key = "<C-\\>";
        mode = [ "n" ];
        action = ":Neotree toggle=true<CR>";
        silent = true;
      }
    ];
    tabline.nvimBufferline = {
      enable = true;
      mappings = {
        closeCurrent = "<C-Del>";
        cycleNext = "<C-]>";
        cyclePrevious = "<C-[>";
      };
    };
    telescope.enable = true;
  };
}
