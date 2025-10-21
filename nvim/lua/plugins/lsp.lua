return {
  { "neovim/nvim-lspconfig" },
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "clangd" },
      })
      require("lspconfig").pyright.setup({})
      require("lspconfig").clangd.setup({})
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {},
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
}
