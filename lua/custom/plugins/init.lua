-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Requirements for other packages
  'nvim-tree/nvim-web-devicons',
  'ryanoasis/vim-devicons',

  -- Telescope
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  },
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require 'alpha.themes.startify'
      require('alpha').setup(startify.config)
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  'jvgrootveld/telescope-zoxide', -- for jump alternative
  'Pocco81/auto-save.nvim', -- autosave all files when entering normal mode
  'voldikss/vim-floaterm', -- for lazygit float term
  'RRethy/vim-illuminate', -- Quick word search under cursor alt+p and alt+n

  'postfen/clipboard-image.nvim',
  'mbbill/undotree', -- needed for with autosave

  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',
  },

  'nvim-telescope/telescope-fzf-native.nvim',
}
