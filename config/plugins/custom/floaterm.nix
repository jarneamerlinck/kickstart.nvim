{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    # Used to format Lua code
    lazygit
    git
    pre-commit

  ];

  # https://nix-community.github.io/nixvim/plugins/floaterm/index.html
  plugins.floaterm = {
    enable = true;
  };
}
