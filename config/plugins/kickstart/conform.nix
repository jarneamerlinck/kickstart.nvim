{ pkgs, ... }:
{
  # Dependencies
  #
  # https://nix-community.github.io/nixvim/NeovimOptions/index.html#extrapackages
  extraPackages = with pkgs; [
    # Used to format Lua code
    stylua # lua
    black # python
    prettier # markdown
    dockfmt # dockerfile
    shfmt # bash/sh
    taplo # Toml
  ];

  # Autoformat
  # https://nix-community.github.io/nixvim/plugins/conform-nvim.html
  plugins.conform-nvim = {
    enable = true;
    settings = {
      notify_on_error = false;
      format_on_save = ''
        function(bufnr)
          -- Disable "format_on_save lsp_fallback" for lanuages that don't
          -- have a well standardized coding style. You can add additional
          -- lanuages here or re-enable it for the disabled ones.
          local disable_filetypes = { c = true, cpp = true }
          if disable_filetypes[vim.bo[bufnr].filetype] then
            return nil
          else
            return {
              timeout_ms = 500,
              lsp_format = "fallback",
            }
          end
        end
      '';
      formatters_by_ft = {
        lua = [ "stylua" ];
        # Conform can also run multiple formatters sequentially
        python = [ "black" ];
        markdown = [ "prettier" ];
        sh = [ "shfmt" ];
        bash = [ "shfmt" ];
        dockerfile = [ "dockfmt" ];
        toml = [ "taplo" ];
        yaml = [ "prettier" ];
        #
        # You can use 'stop_after_first' to run the first available formatter from this list
        #javascript = {
        # __unkeyed-1 = "prettierd";
        # __unkeyed-2 = "prettier";
        # stop_after_first = true;
        #};
      };
    };
  };

  # https://nix-community.github.io/nixvim/keymaps/index.html
  keymaps = [
    {
      mode = "";
      key = "<leader>f";
      action.__raw = ''
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end
      '';
      options = {
        desc = "[F]ormat buffer";
      };
    }
  ];
}
