{
  pkgs,
  config,
  ...
}:
let
  enable_nerd_fonts = true;
  hasStylix = config ? stylix && (config.stylix.enable or false);
in
{

  imports = [
    # Keybinds
    ./config/keybinds.nix
    # Plugins
    ./config/plugins/kickstart/gitsigns.nix
    ./config/plugins/kickstart/which-key.nix
    ./config/plugins/kickstart/telescope.nix
    ./config/plugins/kickstart/lsp.nix
    ./config/plugins/kickstart/conform.nix
    ./config/plugins/kickstart/blink-cmp.nix
    ./config/plugins/kickstart/todo-comments.nix
    ./config/plugins/kickstart/mini.nix
    ./config/plugins/kickstart/treesitter.nix

    ./config/plugins/kickstart/debug.nix
    ./config/plugins/kickstart/indent-blankline.nix
    ./config/plugins/kickstart/lint.nix
    ./config/plugins/kickstart/autopairs.nix
    #

    # Custom plugins
    ./config/plugins/custom/alpha.nix
    ./config/plugins/custom/auto-save.nix
    ./config/plugins/custom/floaterm.nix
    ./config/plugins/custom/snacks.nix
  ];

  /*
    =====================================================================
    ==================== READ THIS BEFORE CONTINUING ====================
    =====================================================================
    ========                                    .-----.          ========
    ========         .----------------------.   | === |          ========
    ========         |.-""""""""""""""""""-.|   |-----|          ========
    ========         ||                    ||   | === |          ========
    ========         ||  KICKSTART.NIXVIM  ||   |-----|          ========
    ========         ||                    ||   | === |          ========
    ========         ||                    ||   |-----|          ========
    ========         ||:Tutor              ||   |:::::|          ========
    ========         |'-..................-'|   |____o|          ========
    ========         `"")----------------(""`   ___________      ========
    ========        /::::::::::|  |::::::::::\  \ no mouse \     ========
    ========       /:::========|  |==hjkl==:::\  \ required \    ========
    ========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
    ========                                                     ========
    =====================================================================
    =====================================================================

    What is Kickstart.nixvim?

      Kickstart.nixvim is a starting point for your own configuration.
        The goal is that you can read every line of code, top-to-bottom, understand
        what your configuration is doing, and modify it to suit your needs.

        Once you've done that, you can start exploring, configuring and tinkering to
        make Neovim your own!

        If you don't know anything about Nixvim, Nix or Lua, I recommend taking some time to read through.
          - https://nix-community.github.io/nixvim/
          - https://learnxinyminutes.com/docs/nix/
          - https://learnxinyminutes.com/docs/lua/

    Kickstart.nixvim Guide:

      The very first thing you should do is to run the command `:Tutor` in Neovim.

        If you don't know what this means, type the following:
          - <escape key>
          - :
          - Tutor
          - <enter key>

        (If you already know the Neovim basics, you can skip this step.)

      Once you've completed that, you can continue working through **AND READING** the rest
      of the nixvim.nix.

      Next, run AND READ `:help`.
        This will open up a help window with some basic information
        about reading, navigating and searching the builtin help documentation.

        This should be the first place you go to look when you're stuck or confused
        with something. It's one of my favorite Neovim features.

        MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
        which is very useful when you're not exactly sure of what you're looking for.

      I have left several `:help X` comments throughout the nixvim.nix and the plugin .nix files
        These are hints about where to find more information about the relevant settings,
        plugins or Neovim features used in Kickstart.nixvim.

      Look for lines like this

        Throughout the file. These are for you, the reader, to help you understand what is happening.
        Feel free to delete them once you know what you're doing, but they should serve as a guide
        for when you are first encountering a few different constructs in your Nixvim Neovim config.

    If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

    I hope you enjoy your Neovim journey,
    - JMartJonesy

    P.S. You can delete this when you're done too. It's your config now! :)
  */

  # Allow stylix for theming
  colorschemes =
    if hasStylix then
      {
        # Stylix-controlled Base16
        base16.enable = true;
      }
    else
      {
        # Fallback colorscheme when Stylix is not installed
        # https://nix-community.github.io/nixvim/colorschemes/tokyonight/index.html
        tokyonight = {
          enable = true;
          settings = {
            # Like many other themes, this one has different styles, and you could load
            # any other, such as 'storm', 'moon', or 'day'.
            style = "night";
            styles = {
              comments = {
                italic = false; # Disable italics in comments
              };
            };
          };
        };
      };
  # https://nix-community.github.io/nixvim/NeovimOptions/index.html#globals
  globals = {
    # Set <space> as the leader key
    # See `:help mapleader`
    mapleader = " ";
    maplocalleader = " ";

    # Set to true if you have a Nerd Font installed and selected in the terminal
    have_nerd_font = enable_nerd_fonts;
  };

  #  See `:help 'clipboard'`
  clipboard = {
    providers = {
      wl-copy.enable = true; # For Wayland
      xsel.enable = true; # For X11
    };

    # Sync clipboard between OS and Neovim
    #  Remove this option if you want your OS clipboard to remain independent.
    register = "unnamedplus";
  };

  # [[ Setting options ]]
  # See `:help vim.o`
  # You can change these options as you wish!
  #  For more options, you can see `:help option-list`
  # https://nix-community.github.io/nixvim/NeovimOptions/index.html#opts
  opts = {
    # Show line numbers
    number = true;
    # You can also add relative line numbers, to help with jumping.
    #  Experiment for yourself to see if you like it!
    # relativenumber = true;

    # Enable mouse mode, can be useful for resizing splits for example!
    mouse = "a";

    # Don't show the mode, since it's already in the statusline
    showmode = false;

    # Enable break indent
    breakindent = true;

    # Save undo history
    undofile = true;

    # Case-insensitive searching UNLESS \C or one or more capital letters in the search term
    ignorecase = true;
    smartcase = true;

    # Keep signcolumn on by default
    signcolumn = "yes";

    # Decrease update time
    updatetime = 250;

    # Decrease mapped sequence wait time
    timeoutlen = 300;

    # Configure how new splits should be opened
    splitright = true;
    splitbelow = true;

    # Sets how neovim will display certain whitespace characters in the editor
    #  See `:help 'list'`
    #  and `:help 'listchars'`
    list = true;
    #  .__raw here means that this field is raw lua code
    listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";

    # Preview substitutions live, as you type!
    inccommand = "split";

    # Show which line your cursor is on
    cursorline = true;

    # Minimal number of screen lines to keep above and below the cursor.
    scrolloff = 10;

    # if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
    # instead raise a dialog asking if you wish to save the current file(s)
    # See `:help 'confirm'`
    confirm = true;

    # See `:help hlsearch`
    hlsearch = true;
  };

  # https://nix-community.github.io/nixvim/NeovimOptions/autoGroups/index.html
  autoGroups = {
    kickstart-highlight-yank = {
      clear = true;
    };
  };

  # [[ Basic Autocommands ]]
  #  See `:help lua-guide-autocommands`
  # https://nix-community.github.io/nixvim/NeovimOptions/autoCmd/index.html
  autoCmd = [
    # Highlight when yanking (copying) text
    #  Try it with `yap` in normal mode
    #  See `:help vim.hl.on_yank()`
    {
      event = [ "TextYankPost" ];
      desc = "Highlight when yanking (copying) text";
      group = "kickstart-highlight-yank";
      callback.__raw = ''
        function()
          vim.hl.on_yank()
        end
      '';
    }
  ];

  diagnostic = {
    settings = {
      severity_sort = true;
      float = {
        border = "rounded";
        source = "if_many";
      };
      underline = {
        severity.__raw = "vim.diagnostic.severity.ERROR";
      };
      signs.__raw = ''
        vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {}
      '';
      virtual_text = {
        source = "if_many";
        spacing = 2;
        format.__raw = ''
          function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end
        '';
      };
    };
  };

  plugins = {
    # Adds icons for plugins to utilize in ui
    web-devicons.enable = enable_nerd_fonts;

    # Detect tabstop and shiftwidth automatically
    # https://nix-community.github.io/nixvim/plugins/sleuth/index.html
    guess-indent = {
      enable = true;
    };
  };

  # https://nix-community.github.io/nixvim/NeovimOptions/index.html#extraplugins
  extraPlugins = with pkgs.vimPlugins; [
    #  This is where you would add a vim plugin that is not implemented in Nixvim, also see extraConfigLuaPre below
  ];

  # https://nix-community.github.io/nixvim/NeovimOptions/index.html#extraconfigluapost
  extraConfigLuaPost = ''
    -- The line beneath this is called `modeline`. See `:help modeline`
    -- vim: ts=2 sts=2 sw=2 et
  '';
}
