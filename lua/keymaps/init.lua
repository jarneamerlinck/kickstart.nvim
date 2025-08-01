-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window creation
keymap('n', '<leader>-', ':new<CR>', opts)
keymap('n', '<leader>|', ':vne<CR>', opts)

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Navigate buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
-- keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
-- keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap('v', 'p', '"_dP', opts)

-- Insert --
-- Press jj fast to enter
keymap('i', 'jj', '<ESC>', opts)

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Plugins --
keymap('n', '<leader>a', ':Alpha<CR>', opts)

-- Telescope
keymap('n', '<leader>ff', ':Telescope find_files hidden=true no_ignore=true<CR>', opts)
keymap('n', '<leader>ft', ':Telescope live_grep<CR>', opts)
keymap('n', '<leader>fp', ':Telescope zoxide list<CR>', opts)
keymap('n', '<leader>fb', ':Telescope buffers<CR>', opts)
keymap('n', '<space>fe', ':Telescope file_browser<CR>', opts)

-- Comment
-- keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
-- keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- Custom
keymap('n', '<leader>p', '<cmd> PasteImg <CR>', opts)
-- keymap("n", "<leader>e", "$", opts)
-- keymap("n", "S", "<cmd> %s//g", opts)
keymap('n', '<F5>', '<cmd> UndotreeToggle <CR> <cmd> UndotreeFocus <CR>', opts)
keymap('n', '<C-\\>', '<cmd> TZAtaraxis <CR>', opts)
keymap('n', '<Leader>1', '1gt<CR>', opts)
keymap('n', '<Leader>2', '2gt<CR>', opts)
keymap('n', '<Leader>3', '3gt<CR>', opts)
keymap('n', '<Leader>4', '4gt<CR>', opts)
keymap('n', '<Leader>5', '5gt<CR>', opts)
keymap('n', '<Leader>t', '<cmd> tabnew<CR>', opts)
keymap('n', '<Leader>c', '<cmd> tabclose<CR>', opts)
keymap('n', '<leader>h', ':tabp<CR>', opts)
keymap('n', '<leader>l', ':tabn<CR>', opts)

-- own Custom
-- term commands
-- keymap("n", "T", ":split term://bash<CR>", opts)
keymap('n', 'tt', ':FloatermNew --height=0.8 --width=0.8<CR>', opts)

keymap('n', '<Leader>V', ':MarkdownPreview<CR>', opts)
keymap('n', '<Leader>P', ":let @+=expand('%:p')<CR>", opts)
-- keymap("n", "<Leader>Wl", ":WorkspacesList<CR>", opts)

keymap('n', '<Leader>G', ':FloatermNew --height=0.8 --width=0.8 lazygit<CR>', opts)

-- compiler commands

-- keymap("n", "<Leader>C", "<cmd>CompilerOpen<cr>", opts)
-- keymap("n", "<Leader>+c", "<cmd>CompilerToggleResults<cr>", opts)

-- reset keymaps

keymap('n', 'gco', '<Nop>', opts)
keymap('n', 'gc0', '<Nop>', opts)
keymap('n', 'gcA', '<Nop>', opts)
-- keymap("n", "<Leader>gco", "<Nop>", opts)
-- keymap("n", "<Leader>Ch", "<Nop>", opts)
-- keymap("n", "<Leader>Cl", "<Nop>", opts)
