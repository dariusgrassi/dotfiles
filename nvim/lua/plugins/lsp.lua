return {
  { "neovim/nvim-lspconfig" },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright" },
      })
      require("lspconfig").pyright.setup({})
    end,
  },
  -- lsp type signature
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      -- cfg options
    },
  },
  -- lsp progress
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },
}
