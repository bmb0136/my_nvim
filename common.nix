{ ... }:
{
  imports = [
    ./files.nix
    ./langs.nix
  ];

  config.vim = {
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = false;
    };

    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };

    options = {
      tabstop = 2;
      shiftwidth = 2;
    };
  };
}
