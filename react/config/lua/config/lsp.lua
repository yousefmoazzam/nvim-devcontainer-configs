vim.lsp.enable({
  "ts_ls",
})

vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    }
  }
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("da", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show all diagnostics in telescope")
    map("ra", "<cmd>Telescope lsp_references<CR>", "Show all binding references in telescope")
    map("th", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>", "Toggle inlay hints")
  end
})

vim.keymap.set(
  'n', 'K',
  function()
    vim.lsp.buf.hover({border = "rounded", title = " hover "})
  end,
  {desc = 'Hover Documentation'}
)
