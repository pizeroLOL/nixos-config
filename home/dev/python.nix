{ pkgs }:
with pkgs;
[
  python313
  python313Packages.python-lsp-server
  pyright
  ruff
  uv
]
