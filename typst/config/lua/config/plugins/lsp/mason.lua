return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    -- enable mason and configure icons
    mason.setup({
      ui = { border = vim.g.border_config },
    })
    mason_lspconfig.setup({
      -- list of language servers for mason to install
      ensure_installed = {
        "tinymist"
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })
  end
}
