-- Telescope - Fuzzy finder for files, grep, buffers, etc.
return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          prompt_position = "bottom",
        },
        sorting_strategy = "descending",
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    -- Enable extensions
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    -- Keymaps
    local builtin = require("telescope.builtin")
    local keymap = vim.keymap.set

    keymap("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    keymap("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    keymap("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find buffers" })
    keymap("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    keymap("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    keymap("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    keymap("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    keymap("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    keymap("n", "<leader>s.", builtin.oldfiles, { desc = "[S]earch Recent Files" })

    -- Search in current buffer
    keymap("n", "<leader>/", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    -- Grep across all open buffers
    keymap("n", "<leader>s/", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, { desc = "[S]earch [/] in Open Files" })
  end,
}
