{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
      language-server = {
        nix-lsp = {
          command = "nixd";
        };
      };
      language = [
        {
          name = "nix";
          language-servers = [ { name = "nix-lsp"; } ];
          indent = {
            tab-width = 2;
            unit = "  ";
          };
          formatter = {
            command = "nixfmt";
          };
        }
      ];
    };
    settings = {
      theme = "onedark";
      editor = {
        mouse = false;
        cursorline = true;
        auto-format = true;
        completion-replace = true;
        true-color = true;
        color-modes = true;
        statusline = {
          left = [
            "mode"
            "spinner"
            "diagnostics"
          ];
          center = [ "file-name" ];
          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          render = true;
          character = "╎"; # Some characters that work well: "▏", "┆", "┊", "⸽"
          skip-levels = 1;
        };
      };
    };
  };
}
