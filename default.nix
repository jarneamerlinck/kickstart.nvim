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
  xdg.configFile."nvim" = {
       source = lib.cleanSource ./kickstart;
       target = "nvim";

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
      xclip
      lua
      luarocks
      go
      shellcheck
      nodejs
      gcc
      clangStdenv
      python39
      yarn

      fzf
      zoxide

      ripgrep
      vimPlugins.telescope-fzf-native-nvim
      lazygit

    ];
  };
}
