local cmd = vim.cmd 		     -- to execute Vim commands
local fn = vim.fn		     -- to call Vim functions q.g. fn.bufnr()
local g = vim.g			     -- a table to access global variable
local opt = vim.opt		     -- to set options

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


require 'paq' {
    'savq/paq-nvim';      -- paq-nvim manages itslf
    'nvim-treesitter/nvim-treesitter';
    'mangeshrex/uwu.vim';
    'junegunn/seoul256.vim';
    'ms-jpq/coq_nvim';    -- auto-completion
    'neovim/nvim-lspconfig';
    'kyazdani42/nvim-web-devicons';
    'kyazdani42/nvim-tree.lua';
    'romgrk/barbar.nvim';
    'nvim-lualine/lualine.nvim';
    'folke/tokyonight.nvim';
    'nvim-lua/plenary.nvim';
    'nvim-telescope/telescope.nvim';
    'nathangrigg/vim-beancount';
}



opt.termguicolors = true
cmd 'colorscheme uwu'		     -- uwu

local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}


opt.mouse = 'a'
g.mapleader = ' '

-- Indent settings
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smartindent = true

-- Split screen settings
opt.splitright = true
opt.splitbelow = true

opt.virtualedit = 'onemore'

opt.title = true

opt.showmatch = true
opt.foldenable = true

opt.number = true
-- opt.relativenumber = true

opt.linebreak = true

require('lualine').setup()
require('nvim-tree').setup()

opt.wrap = true
opt.linebreak = true

opt.clipboard = 'unnamed,unnamedplus'

-- Set barbar's options
g.bufferline = {
    -- Enable/disable animations
    animation = true,

    -- Enable/disable auto-hiding the tab bar when there is a single buffer
    auto_hide = false,

    -- Enable/disable current/total tabpages indicator (top right corner)
    tabpages = true,

    -- Enable/disable close button
    closable = true,

    -- Enables/disable clickable tabs
    --  - left-click: go to buffer
    --  - middle-click: delete buffer
    clickable = true,

    -- Excludes buffers from the tabline
    exclude_ft = {'javascript'},
    exclude_name = {'package.json'},

    -- Enable/disable icons
    -- if set to 'numbers', will show buffer index in the tabline
    -- if set to 'both', will show buffer index and icons in the tabline
    icons = true,

    -- If set, the icon color will follow its corresponding buffer
    -- highlight group. By default, the Buffer*Icon group is linked to the
    -- Buffer* group (see Highlighting below). Otherwise, it will take its
    -- default value as defined by devicons.
    icon_custom_colors = false,

    -- Configure icons on the bufferline.
    icon_separator_active = '▎',
    icon_separator_inactive = '▎',
    icon_close_tab = '',
    icon_close_tab_modified = '●',
    icon_pinned = '車',

    -- If true, new buffers will be inserted at the start/end of the list.
    -- Default is to insert after current buffer.
    insert_at_end = false,
    insert_at_start = false,

    -- Sets the maximum padding width with which to surround each tab
    maximum_padding = 1,

    -- Sets the maximum buffer name length.
    maximum_length = 30,

    -- If set, the letters for each buffer in buffer-pick mode will be
    -- assigned based on their name. Otherwise or in case all letters are
    -- already assigned, the behavior is to assign letters in order of
    -- usability (see order below)
    semantic_letters = true,

    -- New buffer letters are assigned in this order. This order is
    -- optimal for the qwerty keyboard layout but might need adjustement
    -- for other layouts.
    letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

    -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
    -- where X is the buffer number. But only a static string is accepted here.
    no_name_title = nil,
}

map('n', '<leader>e', '<cmd>lua require"custom.tree".toggle()<CR>')       -- Copy to clipboard in normal, visual, select and operator modes
map('n', 'gx', '<cmd>!open <cWORD><CR>')       -- Copy to clipboard in normal, visual, select and operator modes