return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    -- enable mason and configure icons
    mason.setup({})
--    mason.setup({
--      ui = {
--        icons = {
--            package_installed = "\u2713",
--            package_pending = "\u279c",
--            package_uninstalled = "\u2717"
--        }
--      }
--    }),
    mason_lspconfig.setup({
      -- list of language servers for mason to install
      ensure_installed = {
        "nim_langserver@v1.6.0"
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })
  end
}
