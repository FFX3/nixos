{ config, lib, pkgs, inputs, ... }:
{
  home = {
    packages = with pkgs; [
      cargo
    ];
  };

  programs.git = {
    enable = true;
    userName = "Justin McIntyre";
    userEmail = "justinmcintyre42@gmail.com";
  };

  imports = [
    ./neovim/neovim.nix
    ./lf/lf.nix
    ./hyprland/hyprland.nix
  ];
}
