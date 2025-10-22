-- Core keymaps (no plugin dependencies)
-- See `:help vim.keymap.set()`

local keymap = vim.keymap.set

-- Clear search highlighting
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Better indenting (stays in visual mode)
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Move selected lines up/down
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better paste (doesn't replace clipboard with deleted text)
keymap("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
keymap("n", "n", "nzzzv", { desc = "Next search result (centered)" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Diagnostic keymaps
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic error" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })

-- Terminal mode escape
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Note: Telescope keymaps (<leader>sf, <leader>sg, <leader><leader>, etc.)
-- will be added in lua/plugins/telescope.lua
