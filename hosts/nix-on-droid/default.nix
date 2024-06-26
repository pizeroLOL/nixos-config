{ pkgs, ... }:

{
  # Simply install just the packages
  environment.packages =
    (with pkgs; [
      openssh

      zsh

      helix

      git
      eza
      bat
      zellij
      trash-cli

      #procps
      killall
      diffutils
      #findutils
      #utillinux
      tzdata
      hostname
      man
      gnugrep
      gnupg
      gnused

      htop
      btop

      ffmpeg
    ])
    ++ import ../../tools/compress.nix { inherit pkgs; };

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    substituters = https://mirrors.cernet.edu.cn/nix-channels/store https://mirror.sjtu.edu.cn/nix-channels/store
  '';

  user = {
    shell = "${pkgs.zsh}/bin/zsh";
    # userName = "pizero";
  };
  # Set your time zone
  time.timeZone = "Asia/Shanghai";
}
