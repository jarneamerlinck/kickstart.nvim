{ pkgs, ... }:
{
  # [[ Basic Keymaps ]]
  #  See `:help vim.keymap.set()`
  # https://nix-community.github.io/nixvim/keymaps/index.html
  keymaps = [
    # Clear highlights on search when pressing <Esc> in normal mode
    #  See `:help hlsearch`
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohlsearch<CR>";
    }
    # Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
    # for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
    # is not what someone will guess without a bit more experience.
    #
    #  This won't work in all terminal emulators/tmux/etc. Try your own mapping
    # or just use <C-\><C-n> to exit terminal mode
    {
      mode = "t";
      key = "<Esc><Esc>";
      action = "<C-\\><C-n>";
      options = {
        desc = "Exit terminal mode";
      };
    }
    # TIP: Disable arrow keys in normal mode
    /*
      {
        mode = "n";
        key = "<left>";
        action = "<cmd>echo 'Use h to move!!'<CR>";
      }
      {
        mode = "n";
        key = "<right>";
        action = "<cmd>echo 'Use l to move!!'<CR>";
      }
      {
        mode = "n";
        key = "<up>";
        action = "<cmd>echo 'Use k to move!!'<CR>";
      }
      {
        mode = "n";
        key = "<down>";
        action = "<cmd>echo 'Use j to move!!'<CR>";
      }
    */
    # Keybinds to make split navigation easier.
    #  Use CTRL+<hjkl> to switch between windows
    #
    #  See `:help wincmd` for a list of all window commands
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w><C-h>";
      options = {
        desc = "Move focus to the left window";
      };
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w><C-l>";
      options = {
        desc = "Move focus to the right window";
      };
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w><C-j>";
      options = {
        desc = "Move focus to the lower window";
      };
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w><C-k>";
      options = {
        desc = "Move focus to the upper window";
      };
    }
    {
      mode = "n";
      key = "<F1>";
      action = "<cmd> UndotreeToggle <CR> <cmd> UndotreeFocus <CR>";
      options = {
        desc = "Move focus to undotree";
      };
    }
    {
      mode = "n";
      key = "tt";
      action = "<cmd>FloatermNew --height=0.8 --width=0.8<CR>";
      options = {
        desc = "Open [T]erminal";
      };
    }
    {
      mode = "n";
      key = "<Leader>td";
      action = "<cmd>lua vim.diagnostic.enable(not vim.diagnostic.is_enabled({bufnr = 0}), {bufnr = 0})<CR>";
      options = {
        desc = "[T]oggle buffer [D]iagnostics";
      };
    }
    {
      mode = "n";
      key = "<Leader>P";
      action = "<cmd>let @+=expand('%:p')<CR>";
      options = {
        desc = "Get path of current file";
      };
    }
    {
      mode = "n";
      key = "<Leader>G";
      action = "<cmd> FloatermNew --height=0.8 --width=0.8 ${pkgs.lazygit}/bin/lazygit<CR>";
      options = {
        desc = "Open lazygit in floaterm";
      };
    }
    {
      mode = "n";
      key = "<Leader>a";
      action = "<cmd>Alpha<CR>";
      options = {
        desc = "Open alpha";
      };
    }

    # Tab movement/control
    {
      mode = "n";
      key = "<Leader>T";
      action = "<cmd> tabnew<CR>";
      options = {
        desc = "Open new tab";
      };
    }
    {
      mode = "n";
      key = "<Leader>C";
      action = "<cmd> tabclose<CR>";
      options = {
        desc = "Close tab";
      };
    }
    {
      mode = "n";
      key = "<Leader>H";
      action = "<cmd>tabp<CR>";
      options = {
        desc = "Move to left tab";
      };
    }
    {
      mode = "n";
      key = "<Leader>L";
      action = "<cmd>tabn<CR>";
      options = {
        desc = "Move to right tab";
      };
    }
    {
      mode = "n";
      key = "<Leader>1";
      action = "1gt<CR>";
      options = {
        desc = "Move to tab 1";
      };
    }
    {
      mode = "n";
      key = "<Leader>2";
      action = "2gt<CR>";
      options = {
        desc = "Move to tab 2";
      };
    }
    {
      mode = "n";
      key = "<Leader>3";
      action = "3gt<CR>";
      options = {
        desc = "Move to tab 3";
      };
    }
    {
      mode = "n";
      key = "<Leader>4";
      action = "4gt<CR>";
      options = {
        desc = "Move to tab 4";
      };
    }
    {
      mode = "n";
      key = "<Leader>5";
      action = "5gt<CR>";
      options = {
        desc = "Move to tab 5";
      };
    }
    {
      mode = "n";
      key = "<Leader>-";
      action = "<cmd>new<CR>";
      options = {
        desc = "Split window horizontal";
      };
    }
    {
      mode = "n";
      key = "<Leader>|";
      action = "<cmd>vne<CR>";
      options = {
        desc = "Split window vertical";
      };
    }

    # Custom plugins
    {
      mode = "n";
      key = "<Leader>gB";
      action = "<cmd>lua require('snacks').gitbrowse()<CR>";
      options = {
        desc = "[G]it [B]rowse (Snacks)";
      };
    }
    {
      mode = "n";
      key = "<Leader>gb";
      action = "<cmd>lua require('snacks').git.blame_line()<CR>";
      options = {
        desc = "[G]it [b]lame";
      };
    }
    {
      mode = "n";
      key = "<Leader>nt";
      action = "<cmd> FloatermNew! --disposable --position=bottom --height=0.3  ${pkgs.devenv}/bin/devenv test -v<CR>";
      options = {
        desc = "Devenv [N]ix [T]est";
      };
    }
  ];

}
