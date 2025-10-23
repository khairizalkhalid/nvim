-- LSP Configuration - Language servers for code intelligence
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Mason: manages LSP servers, formatters, linters
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Status updates for LSP
    {
      "j-hui/fidget.nvim",
      opts = {
        notification = {
          window = {
            winblend = 0, -- Needed to prevent black background
            normal_hl = "Normal", -- Use normal background
            border = "rounded", -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
          },
        },
      },
    },
  },
  config = function()
    -- This function runs when LSP attaches to a buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Jump to definition/references (kickstart style with 'gr' prefix)
        map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
        map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- Symbols in document/workspace
        map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
        map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

        -- Code actions
        map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction")
        map("K", vim.lsp.buf.hover, "Hover Documentation")

        -- Highlight references under cursor
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    -- LSP servers to install
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            completion = { callSnippet = "Replace" },
            diagnostics = { disable = { "missing-fields" } },
          },
        },
      },
      -- Add more servers here as needed:
      -- gopls = {},
      -- rust_analyzer = {},
      -- clangd = {},
      -- pyright = {},
      -- ts_ls = {}, -- TypeScript
    }

    -- Capabilities for autocompletion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

    -- Setup Mason to install servers
    require("mason").setup()
    require("mason-tool-installer").setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,
}
