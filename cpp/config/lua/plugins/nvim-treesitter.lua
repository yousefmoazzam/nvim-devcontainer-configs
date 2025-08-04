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
          "python",
          "yaml",
          "markdown",
          "bash",
          "lua",
          "vim",
          "dockerfile",
          "gitignore",
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
