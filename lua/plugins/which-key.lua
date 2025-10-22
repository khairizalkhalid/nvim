-- Which-key - Shows keybinding helper at the bottom
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.setup({
      preset = "modern",
      delay = 0, -- No delay when which-key is shown
      icons = {
        mappings = false, -- Set to true if you have Nerd Font
      },
      -- Don't show which-key automatically
      triggers = {},
    })

    -- Register key groups for better organization
    wk.add({
      { "<leader>s", group = "[S]earch" },
      { "<leader>h", group = "[H]unk/Help" },
      { "<leader>c", group = "[C]laude" },
      { "<leader>d", group = "[D]ocument" },
      { "<leader>w", group = "[W]orkspace" },
      { "<leader>g", group = "[G]it" },
    })

    -- Toggle which-key manually with <leader>?
    vim.keymap.set("n", "<leader>?", function()
      require("which-key").show({ global = true })
    end, { desc = "Show keybindings help" })
  end,
}

-- USAGE:
-- <leader>? - Toggle keybinding helper at the bottom
-- Once shown, start typing a key sequence to see available bindings
-- Press <Esc> to close
