return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      -- configure treesitter
      treesitter.setup({ -- enable syntax highlighting
        -- ensure these language parsers are installed
        ensure_installed = {
          "yaml",
          "markdown",
          "bash",
          "lua",
          "vim",
          "dockerfile",
          "gitignore",
          "svelte",
          "typescript",
          "html",
          "css",
        },
        sync_install = false,
        highlight = {
          enable = true,
        },
        -- enable indentation
        indent = { enable = true },
        -- auto install above language parsers
        auto_install = true,
      })
    end,
  },
}
