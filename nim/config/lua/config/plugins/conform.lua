return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        nim = { "nph" }
      },
      format_on_save = {
        lsp_fallback = false,
        async = false,
        timeout_ms = 5000
      }
    })
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = false,
        async = false,
        timeout_ms = 500
      })
    end, { desc = "Format file or range (in visual mode)" })
  end
}
