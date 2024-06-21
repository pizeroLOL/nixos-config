# 个人使用 nixos 的配置文件

## 使用教程

1. 挂载磁盘到 `/mnt`
2. `nixos-generate-config --root /mnt`
3. `git clone <仓库地址> && cd <仓库地址>`
4. 将 <仓库地址> 内的文件复制到 `/mnt` 内的任意地址
5. 根据生成的 `hardware-configuration.nix` 修改 `hosts/nixos-to-go/configuration.nix` 内的 UUID 和挂载选项
6. 根据生成的 `configuration.nix` 修改 `hosts/nixos-to-go/configuration.nix` 内的 `system.stateVersion`
7. `wget https://aur.archlinux.org/cgit/aur.git/plain/license.tar.gz\?h\=wechat-uos-bwrap -o license.tar.gz && nix store add-file license.tar.gz`
8. `nixos-rebuild boot --flake <仓库地址>#nixos-to-go`
9. `reboot`

## 推荐教程

- [入门](https://nixos-and-flakes.thiscute.world/zh/preface)
- [官方安装手册](https://nixos.org/learn/)

<!-- TODO: ## 目录结构 -->
