return {
  { "neovim/nvim-lspconfig" },
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "pyright",
        "clangd",
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      local lspconfig = require("lspconfig")

      -- Python setup
      lspconfig.pyright.setup({})

      -- C/C++ setup
      lspconfig.clangd.setup({
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
        },
      })
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
