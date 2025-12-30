{
  self,
  pkgs,
  lib,
  modules ? [],
  ...
}:
pkgs.writeShellApplication rec {
  name = "mkvim";
  text = ''
    if [[ $# -lt 1 ]]; then
      echo "Usage: ${name} <language> [nvim arguments]"
      exit 1
    fi
    lang=$1
    shift
    my_nvim="${self}"
    system="${pkgs.stdenv.hostPlatform.system}"
    args="enable-$lang=true;"
    args+='modules=builtins.fromJSON "${lib.escapeShellArg (builtins.toJSON modules)}";'
    result=$(nix-build --expr "(builtins.getFlake \"$my_nvim\").packages.\"$system\".default.override { $args }" --no-out-link)
    "$result/bin/nvim" "$@"
  '';
}
