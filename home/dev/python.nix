{ pkgs }:
with pkgs;
[
  python312
  python312Packages.python-lsp-server
  pyright
  ruff
  ruff-lsp
  uv
]
