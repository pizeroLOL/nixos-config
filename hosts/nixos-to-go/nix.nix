{
  # 允许非自由软件
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    # 镜像站
    substituters = [
      # "https://mirror.sjtu.edu.cn/nix-channels/store"
      # "https://mirrors.cernet.edu.cn/nix-channels/store"
      # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
      # cosmic
      "https://cosmic.cachix.org/"
    ];

    # cosmic
    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];

    # 实验性功能
    experimental-features = [
      "nix-command"
      "flakes"
      "ca-derivations"
    ];
  };
}
