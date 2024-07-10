{ pkgs }:
with pkgs;
[
  bun
  nodejs_20
  nodePackages.eslint
  nodePackages.prettier
  nodePackages.typescript-language-server
  vue-language-server
  vscode-langservers-extracted
]
