-- Formatting with conform.nvim
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
    {
      "<leader>tf",
      function()
        if vim.b.disable_autoformat or vim.g.disable_autoformat then
          vim.b.disable_autoformat = false
          vim.g.disable_autoformat = false
          print("Format on save: enabled")
        else
          vim.b.disable_autoformat = true
          print("Format on save: disabled")
        end
      end,
      desc = "[T]oggle [F]ormat on save",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable format on save if toggled off
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return {
        timeout_ms = 500,
        lsp_fallback = true,
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      go = { "goimports", "gofmt" },
      rust = { "rustfmt" },
      java = { 'javaformatter', 'remove_empty_import_lines' },
      -- Add more formatters as needed
    },
    formatters = {
      javaformatter = {
        command = 'java',
        args = {
          '-jar',
          vim.env.GOOGLE_JAVA_FORMAT_JAR,
          '--aosp',
          '--skip-javadoc-formatting',
          '-',
        },
      },
      remove_empty_import_lines = {
        command = 'perl',
        args = {
          '-0777',
          '-pe',
          '1 while s/(import[^\n]*\n)\n+(?=import)/$1/g',
        },
      },
    },
  },
}

-- USAGE:
-- <leader>f - Format current buffer manually
-- <leader>tf - Toggle format on save (enabled by default)
--
-- To install formatters, use Mason:
-- :Mason
-- Then search for formatters like: stylua, prettier, black, etc.
