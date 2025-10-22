-- Treesitter - Better syntax highlighting and code understanding
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Install parsers for these languages
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "c",
        "cpp",
        "go",
        "rust",
        "python",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
        "markdown",
        "markdown_inline",
      },
      auto_install = true, -- Auto-install missing parsers when entering buffer
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
