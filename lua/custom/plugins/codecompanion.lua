return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('codecompanion').setup {
      -- The strategies to use for each type of code action
      -- The default is to use the copilot adapter for both strategies
      opt = {
        strategies = {
          chat = {
            adapter = 'copilot',
          },
          inline = {
            adapter = 'copilot',
          },
        },
      },
    }
    vim.api.nvim_set_keymap('n', '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd [[cab cc CodeCompanion]]
  end,
}
