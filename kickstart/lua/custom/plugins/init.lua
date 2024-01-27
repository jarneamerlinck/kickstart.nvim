-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
-- File Explorer in Vim Ctrl+f
 {
 "nvim-telescope/telescope-file-browser.nvim",
 dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
 };
-- Use Ctrl+fp to list recent git projects
  "ahmedkhalf/project.nvim",
-- alpha dashboard
  {
  "goolord/alpha-nvim", -- frontpage
  dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
        require"alpha".setup(require"alpha.themes.startify".config)
  end
  },
  {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  },

  "jvgrootveld/telescope-zoxide",-- for jump alternative
  "nvim-tree/nvim-web-devicons",
  "ryanoasis/vim-devicons",
  -- Colorschemes
  "lunarvim/darkplus.nvim",
  "arcticicestudio/nord-vim",
  "emacs-grammarly/lsp-grammarly",
  "WhoIsSethDaniel/mason-tool-installer.nvim", -- mason (autofill and fix) installer
-- Quick word search under cursor alt+p and alt+n
  "RRethy/vim-illuminate",
-- Titus Custom
  "postfen/clipboard-image.nvim",
  "mbbill/undotree", -- needed for with autosave
--  "wakatime/vim-wakatime",
  "Pocco81/auto-save.nvim", -- autosave all files when entering normal mode
  "Pocco81/true-zen.nvim",
  "lambdalisue/suda.vim", -- write as sudo
  "lunarvim/synthwave84.nvim", -- code theme
  "natecraddock/workspaces.nvim",
  "voldikss/vim-floaterm",-- for lazygit float term
  { -- This plugin
  "Zeioth/compiler.nvim",
  cmd = {"CompilerOpen", "CompilerToggleResults", "CompilerRedo"},
  dependencies = { "stevearc/overseer.nvim" },
  opts = {},
  },
  { -- The task runner we use
  "stevearc/overseer.nvim",
  cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
  opts = {
    task_list = {
      direction = "bottom",
      min_height = 25,
      max_height = 25,
      default_detail = 1
    },
    },
  },
  --"mfussenegger/nvim-dap" -- Debug Adapter Protocol
  -- next
  {
  "kkoomen/vim-doge",
  build = ":call doge#install()",
  },
  "elentok/format-on-save.nvim", -- autosave format for with mason
  "fsouza/prettierd", -- for format on save

  -- needs npm install -g @fsouza/prettierd
  -- ipython notebooks nvim
 --  "untitled-ai/jupyter_ascending.vim",
 --  "bfredl/nvim-ipy",
 --  "hkupty/iron.nvim",
 --  "GCBallesteros/jupytext.vim",
 --  "kana/vim-textobj-line",
 --  "kana/vim-textobj-user",
 --  "GCBallesteros/vim-textobj-hydrogen",

}
