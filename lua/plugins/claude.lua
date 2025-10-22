-- Claude Code integration using greggh/claude-code.nvim
-- Integrates the actual Claude CLI you're using in terminal
return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("claude-code").setup({
      window ={
        split_ratio = 0.45, -- Claude window takes 45% of screen width
        position = "vertical", -- Vertical split (left/right)
      }
    })

    -- Keybindings
    vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<cr>", { desc = "Claude Code" })
    vim.keymap.set("v", "<leader>cc", "<cmd>ClaudeCode<cr>", { desc = "Claude Code with selection" })
    vim.keymap.set("n", "<leader>ct", "<cmd>ClaudeCodeToggle<cr>", { desc = "Claude Code Toggle" })
  end,
}

-- USAGE:
-- <leader>cc - Open Claude Code prompt (or send selection in visual mode)
-- <leader>ct - Toggle Claude Code window
-- Make sure you have 'claude' CLI installed and authenticated
