-- Autocompletion using blink.cmp (faster, better defaults)
return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "1.*",
  dependencies = {
    -- Snippet engine
    {
      "L3MON4D3/LuaSnip",
      version = "2.*",
      build = (function()
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
    },
  },
  opts = {
    keymap = {
      preset = "default", -- <c-y> to accept, <c-n>/<c-p> to navigate
      -- Other presets: 'super-tab', 'enter'
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      menu = {
        border = "rounded",
        -- Show icon + kind on the right, label on the left
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 },
          },
        },
      },
      documentation = {
        auto_show = false,
        auto_show_delay_ms = 500,
        window = {
          border = "rounded",
        },
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    snippets = {
      preset = "luasnip",
    },

    signature = {
      enabled = true, -- Show function signature while typing
    },
  },
}
