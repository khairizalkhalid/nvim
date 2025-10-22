-- Colorscheme configuration
-- To switch colorschemes, change the vim.cmd.colorscheme() line at the bottom

return {
  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true,
        no_italic = true,
        styles = {
          comments = {},
          conditionals = {},
        },
      })

      -- Activate catppuccin
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- TokyoNight (alternative)
  {
    "folke/tokyonight.nvim",
    lazy = true,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        styles = {
          comments = { italic = false },
          sidebars = "transparent",
          floats = "transparent",
        },
      })
    end,
  },

  -- Rose Pine (alternative)
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    config = function()
      require("rose-pine").setup({
        variant = "main",
        disable_background = true,
        disable_float_background = true,
        styles = {
          italic = false,
          transparency = true,
        },
      })
    end,
  },
}
