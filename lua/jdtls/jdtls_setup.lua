local M = {}

function M.setup()
  -- local jdtls = require 'jdtls'
  local jdtls_dap = require 'jdtls.dap'
  local jdtls_setup = require 'jdtls.setup'
  local home = os.getenv 'HOME'
  local java_home = os.getenv 'JAVA_HOME_21'

  local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
  local root_dir = jdtls_setup.find_root(root_markers)

  local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
  local workspace_dir = home .. '/.cache/jdtls/workspace/' .. project_name

  -- 💀
  -- local path_to_mason_packages = home .. "/.local/share/nvim/mason/packages"
  -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^

  -- local path_to_jdtls = path_to_mason_packages .. "/jdtls"
  -- local path_to_jdebug = path_to_mason_packages .. "/java-debug-adapter"
  -- local path_to_jtest = path_to_mason_packages .. "/java-test"

  -- local path_to_config = path_to_jdtls .. "/config_linux"
  -- local lombok_path = path_to_jdtls .. "/lombok.jar"
  local path_to_config = home .. '/Desktop/workspace/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_mac_arm'
  local lombok_path = home .. '/.local/share/nvim/dependencies/lombok.jar'

  -- 💀
  -- local path_to_jar = path_to_jdtls .. "/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar"
  local path_to_jar = home
    .. '/Desktop/workspace/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar'
  -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^

  -- local bundles = {
  --   vim.fn.glob(path_to_jdebug .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
  -- }

  -- vim.list_extend(bundles, vim.split(vim.fn.glob(path_to_jtest .. "/extension/server/*.jar", true), "\n"))

  -- LSP settings for Java.
  local on_attach = function(_, bufnr)
    -- jdtls.setup_dap({ hotcodereplace = "auto" })
    jdtls_dap.setup_dap_main_class_configs()
    jdtls_setup.add_commands()

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    -- require('lsp_signature').on_attach({
    --   bind = true,
    --   padding = '',
    --   handler_opts = {
    --     border = 'rounded',
    --   },
    --   hint_prefix = '󱄑 ',
    -- }, bufnr)

    -- NOTE: comment out if you don't use Lspsaga
    -- require 'lspsaga'.init_lsp_saga()
  end

  local capabilities = {
    workspace = {
      configuration = true,
    },
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
    },
  }

  local config = {
    flags = {
      allow_incremental_sync = true,
    },
  }

  config.cmd = {
    --
    -- 				-- 💀
    -- "java", -- or '/path/to/java17_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.
    java_home .. 'bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '-javaagent:' .. lombok_path,
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    -- 💀
    '-jar',
    path_to_jar,
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version
    -- 💀
    '-configuration',
    path_to_config,
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.
    -- 💀
    -- See `data directory configuration` section in the README
    '-data',
    workspace_dir,
  }

  config.settings = {
    java = {
      references = {
        includeDecompiledSources = true,
      },
      -- format = {
      --   enabled = true,
      --   settings = {
      --     url = vim.fn.stdpath 'config' .. '/lang_servers/intellij-java-google-style.xml',
      --     profile = 'GoogleStyle',
      --   },
      -- },
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      -- eclipse = {
      -- 	downloadSources = true,
      -- },
      -- implementationsCodeLens = {
      -- 	enabled = true,
      -- },
      completion = {
        favoriteStaticMembers = {
          'org.hamcrest.MatcherAssert.assertThat',
          'org.hamcrest.Matchers.*',
          'org.hamcrest.CoreMatchers.*',
          'org.junit.jupiter.api.Assertions.*',
          'java.util.Objects.requireNonNull',
          'java.util.Objects.requireNonNullElse',
          'org.mockito.Mockito.*',
        },
        filteredTypes = {
          'com.sun.*',
          'io.micrometer.shaded.*',
          'java.awt.*',
          'jdk.*',
          'sun.*',
        },
        importOrder = {
          'java',
          'javax',
          'com',
          'org',
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
          -- flags = {
          -- 	allow_incremental_sync = true,
          -- },
        },
        useBlocks = true,
      },
      -- configuration = {
      --     runtimes = {
      --         {
      --             name = "java-17-openjdk",
      --             path = "/usr/lib/jvm/default-runtime/bin/java"
      --         }
      --     }
      -- }
      -- project = {
      -- 	referencedLibraries = {
      -- 		"**/lib/*.jar",
      -- 	},
      -- },
    },
  }

  config.on_attach = on_attach
  config.capabilities = capabilities
  config.on_init = function(client, _)
    client.notify('workspace/didChangeConfiguration', { settings = config.settings })
  end

  local extendedClientCapabilities = require('jdtls').extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  config.init_options = {
    -- bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities,
  }

  -- Start Server
  require('jdtls').start_or_attach(config)

  -- Set Java Specific Keymaps
  -- require 'jdtls.keymaps'

  -- NOTE: Java specific keymaps with which key
  --   vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
  --   vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
  --   vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
  --   vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
  --   vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
  --   vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"
  --
  --   local status_ok, which_key = pcall(require, 'which-key')
  --   if not status_ok then
  --     return
  --   end
  --
  --   local opts = {
  --     mode = 'n', -- NORMAL mode
  --     prefix = '<leader>',
  --     buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  --     silent = true, -- use `silent` when creating keymaps
  --     noremap = true, -- use `noremap` when creating keymaps
  --     nowait = true, -- use `nowait` when creating keymaps
  --   }
  --
  --   local vopts = {
  --     mode = 'v', -- VISUAL mode
  --     prefix = '<leader>',
  --     buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  --     silent = true, -- use `silent` when creating keymaps
  --     noremap = true, -- use `noremap` when creating keymaps
  --     nowait = true, -- use `nowait` when creating keymaps
  --   }
  --
  --   local mappings = {
  --     J = {
  --       name = 'Java',
  --       o = { "<Cmd>lua require'jdtls'.organize_imports()<CR>", 'Organize Imports' },
  --       v = { "<Cmd>lua require('jdtls').extract_variable()<CR>", 'Extract Variable' },
  --       c = { "<Cmd>lua require('jdtls').extract_constant()<CR>", 'Extract Constant' },
  --       t = { "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", 'Test Method' },
  --       T = { "<Cmd>lua require'jdtls'.test_class()<CR>", 'Test Class' },
  --       u = { '<Cmd>JdtUpdateConfig<CR>', 'Update Config' },
  --     },
  --   }
  --
  --   local vmappings = {
  --     J = {
  --       name = 'Java',
  --       v = { "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", 'Extract Variable' },
  --       c = { "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", 'Extract Constant' },
  --       m = { "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", 'Extract Method' },
  --     },
  --   }
  --
  --   which_key.register(mappings, opts)
  --   which_key.register(vmappings, vopts)
  --
  --   -- If you want you can add here Old School Mappings. Me I setup Telescope, LSP and Lspsaga mapping somewhere else and I just reuse them
  --
  --   -- vim.keymap.set("gI", vim.lsp.buf.implementation,{ desc = "[G]oto [I]mplementation" })
  --   -- vim.keymap.set("<leader>D", vim.lsp.buf.type_definition,{ desc = "Type [D]efinition" })
  --   -- vim.keymap.set("<leader>hh", vim.lsp.buf.signature_help,{ desc = "Signature [H][H]elp Documentation" })
  --
  --   -- vim.keymap.set("gD", vim.lsp.buf.declaration,{ desc = "[G]oto [D]eclaration" })
  --   -- vim.keymap.set("<leader>wa", vim.lsp.buf.add_workspace_folder,{ desc = "[W]orkspace [A]dd Folder" })
  --   -- vim.keymap.set("<leader>wr", vim.lsp.buf.remove_workspace_folder,{ desc = "[W]orkspace [R]emove Folder" })
  --   -- vim.keymap.set("<leader>wl", function()
  --   --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  --   -- end, "[W]orkspace [L]ist Folders")
  --
  --   -- Create a command `:Format` local to the LSP buffer
  --   -- vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
  --   --   vim.lsp.buf.format()
  --   -- end, { desc = "Format current buffer with LSP" })
  --
  --   -- vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "[G]oto [R]eferences - Java", expr = true, silent = true })
  --   -- vim.keymap.set("n","gr", require("telescope.builtin").lsp_references,{ desc = "[G]oto [R]eferences" })
  --   -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "" })
  --   -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "" })
  --   -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "" })
  --   -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "" })
  --   -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "" })
  --   -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = "" })
  --   -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = "" })
  --   -- vim.keymap.set('n', '<leader>wl', print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', { desc = "" })
  --   -- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = "" })
  --   -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "" })
  --   -- vim.keymap.set('n', 'gr', vim.lsp.buf.references() && vim.cmd("copen")<CR>', { desc = "" })
  --   -- vim.keymap.set('n', '<leader>e', vim.lsp.diagnostic.show_line_diagnostics, { desc = "" })
  --   -- vim.keymap.set('n', '[d', vim.lsp.diagnostic.goto_prev, { desc = "" })
  --   -- vim.keymap.set('n', ']d', vim.lsp.diagnostic.goto_next, { desc = "" })
  --   -- vim.keymap.set('n', '<leader>q', vim.lsp.diagnostic.set_loclist, { desc = "" })
  --
  --   -- -- Java specific
  --   -- vim.keymap.set("n", "<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = "" })
  --   -- vim.keymap.set("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", { desc = "" })
  --   -- vim.keymap.set("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", { desc = "" })
  --   -- vim.keymap.set("v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { desc = "" })
  --   -- vim.keymap.set("n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = "" })
  --   -- vim.keymap.set("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = "" })
  --   --
  --   -- vim.keymap.set("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", { desc = "" })
end

return M
