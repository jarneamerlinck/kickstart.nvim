{
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    initExtraBeforeCompInit = ''
    eval "$(zoxide init zsh)"
    '';
  };
  home = {
    shellAliases = {
      v="nvim";
    };

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    packages = with pkgs; [
      neovim
      ripgrep
      xclip
      lua
      luarocks
      go
      shellcheck
      nodejs
      gcc
      clangStdenv
      python39
      fzf
      zoxide

      vimPlugins.telescope-fzf-native-nvim
      lazygit

    ];
    xdg.configFile."nvim" = {
       source = lib.cleanSource ./kickstart.nvim;

    }
  };
}
