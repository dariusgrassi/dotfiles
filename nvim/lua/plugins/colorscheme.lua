return {
  -- Add the monokai-pro theme plugin
  {
    "loctvl842/monokai-pro.nvim",
    priority = 1000, -- Make sure it loads early
    config = function()
      -- Optional: configure the theme
      require("monokai-pro").setup({
        filter = "pro", -- Or "classic", "machine", "octagon", "ristretto", "spectrum"
      })
    end,
  },

  -- Override LazyVim's default theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monokai-pro",
    },
  },
}
