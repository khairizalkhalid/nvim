-- Java-specific configuration for jdtls
-- This overrides the default lspconfig setup for Java files

local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name

-- Get the lombok jar path
local lombok_path = jdtls_path .. "/lombok.jar"

-- Configuration
local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. lombok_path,
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration", jdtls_path .. "/config_mac",
    "-data", workspace_dir,
  },

  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" }, -- Use fernflower for decompiling
      completion = {
        favoriteStaticMembers = {
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.Assert.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-21",
            path = vim.env.JAVA_HOME_21,
            default = true,
          },
        },
      },
    },
  },

  init_options = {
    bundles = {},
  },

  capabilities = require("blink.cmp").get_lsp_capabilities(),
}

-- Start jdtls
require("jdtls").start_or_attach(config)
