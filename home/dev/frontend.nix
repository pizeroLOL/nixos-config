{ pkgs }:
with pkgs;
[
  bun
  nodejs_22
  pnpm_10
  nodePackages.eslint
  nodePackages.prettier
  nodePackages.typescript-language-server
  vue-language-server
  vscode-langservers-extracted
]
