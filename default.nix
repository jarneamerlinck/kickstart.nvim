{
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    initExtraBeforeCompInit = ''
    eval "$(zoxide init zsh)"
    if [ -n "${commands[fzf-share]}" ]; then
      source "$(fzf-share)/key-bindings.zsh"
      source "$(fzf-share)/completion.zsh"
    fi
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
