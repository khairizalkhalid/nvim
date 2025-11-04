-- Core Neovim options
-- See `:help vim.opt` for more information

local opt = vim.opt

-- Leader keys (must be set before plugins load)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Netrw settings
vim.g.netrw_liststyle = 3     -- Tree view
vim.g.netrw_banner = 1        -- Show banner
vim.g.netrw_winsize = 25      -- Window size (25% of screen)

-- Line numbers
opt.number = true         -- Show absolute line number
opt.relativenumber = true -- Show relative line numbers

-- Indentation
opt.tabstop = 4           -- Number of spaces tabs count for
opt.shiftwidth = 4        -- Size of an indent
opt.expandtab = true      -- Use spaces instead of tabs
opt.smartindent = true    -- Insert indents automatically

-- Search
opt.ignorecase = true     -- Ignore case when searching
opt.smartcase = true      -- Override ignorecase if search contains capitals
opt.inccommand = "split"  -- Preview substitutions live

-- UI
opt.cursorline = true     -- Highlight cursor line
opt.signcolumn = "yes"    -- Always show sign column (prevents text shift)
opt.scrolloff = 10        -- Lines to keep above/below cursor
opt.wrap = true          -- Disable line wrapping
opt.termguicolors = true  -- True color support
opt.showmode = false      -- Don't show mode (statusline shows it)
opt.showcmd = true        -- Show partial commands in bottom right

-- Splits
opt.splitright = true     -- Vertical split to the right
opt.splitbelow = true     -- Horizontal split to the bottom

-- Files
opt.undofile = true       -- Save undo history
opt.swapfile = false      -- Disable swap file
opt.backup = false        -- Disable backup file

-- Behavior
opt.mouse = "a"           -- Enable mouse support
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.updatetime = 250      -- Faster completion
opt.timeoutlen = 1000     -- Time to wait for key sequence (milliseconds)
opt.confirm = true        -- Confirm to save changes before exiting

-- Whitespace characters
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- LSP UI - Add borders to floating windows
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

-- Diagnostic floating windows with borders
vim.diagnostic.config({
  float = { border = "rounded" },
})
