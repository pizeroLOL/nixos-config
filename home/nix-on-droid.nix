{ pkgs, ... }:
{
  imports = [
    ./settings/helix.nix
    ./settings/starship.nix
  ];
  home.stateVersion = "24.05";
  home.packages =
    (with pkgs; [
      rustup

      nnn
      nmap

      maa-cli
      maa-assistant-arknights
    ])
    ++ import ./dev/nix.nix { inherit pkgs; }
    ++ import ./dev/python.nix { inherit pkgs; };
  home.file."./.config/sshd/sshd.cfg".text = ''
    HostKey /data/data/com.termux.nix/files/home/.ssh/id_ed25519
    Port 20022
  '';

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases =
      let
        cfg = "/data/data/com.termux.nix/files/home/.config/nix-on-droid";
      in
      {
        # ou = "nix update /data/data/com.termux.nix/files/home/.config/nix-on-droid"
        # os = "nix-on-droid switch --flake /data/data/com.termux.nix/files/home/.config/nix-on-droid#"
        ou = "nix flake update ${cfg}";
        os = "nix-on-droid switch --flake ${cfg}#pizero-phone";
        sd = "$(which sshd) -f ~/.config/sshd/sshd.cfg -D";
      };
    oh-my-zsh.enable = true;
  };
}
