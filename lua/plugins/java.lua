-- nvim-jdtls: Enhanced Java support for jdtls
-- This provides better integration with jdtls than the default lspconfig
return {
  "mfussenegger/nvim-jdtls",
  ft = "java", -- Only load for Java files
  dependencies = {
    "williamboman/mason.nvim",
  },
  -- Configuration is done in ftplugin/java.lua
  -- This plugin provides the require("jdtls") module used there
}
