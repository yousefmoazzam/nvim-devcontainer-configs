return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    -- { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap -- just to keep code a bit shorter

    --local opts = { noremap = true, silent = true, autoformat = false }
    local opts = { noremap = true, silent = true }
    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      -- NOTE: Temporary fix to "server cancelled" error when typing, taken
      -- from:
      -- https://github.com/neovim/neovim/issues/30985#issuecomment-2447329525
      for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
          local default_diagnostic_handler = vim.lsp.handlers[method]
          vim.lsp.handlers[method] = function(err, result, context, config)
              if err ~= nil and err.code == -32802 then
                  return
              end
              return default_diagnostic_handler(err, result, context, config)
          end
      end

      -- Toggle inlay type hints
      -- Cobbled together from various sources:
      -- - https://github.com/mrcjkb/rustaceanvim/discussions/46#discussioncomment-8566218
      -- - https://github.com/mrcjkb/rustaceanvim/discussions/368
      -- - https://www.reddit.com/r/neovim/comments/14em0f8/how_to_use_the_new_lsp_inlay_hints/
      -- - https://www.reddit.com/r/neovim/comments/18y4bhz/neovim_inlay_hints_only_enable_if_i_first_run_a/
      if client.server_capabilities.inlayHintProvider then
        opts.desc = "Toggle inlay hints"
        keymap.set('n', '<leader>th', function()
          local current_setting = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
          vim.lsp.inlay_hint.enable(not current_setting)
        end, opts)
      end

      -- set keybinds
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- LSP settings (for overriding per client)
    local handlers =  {
      ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = vim.g.border}),
      ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = vim.g.border }),
    }

    -- add border to :LspInfo floating window too
    --vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
    --vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
    --vim.cmd [[autocmd! ColorScheme * highlight FloatBorder ctermfg=NONE ctermbg=NONE cterm=NONE]]
    require('lspconfig.ui.windows').default_options = { border = vim.g.border }

    -- fiddlign with diagnostics window, including:
    -- - adding a border to the floating window
    -- - making the disganotics update while in insert mode
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = true,
      severity_sort = false,
      float = {
        border = vim.g.border,
      },
    })

    -- configure rust language server
    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        ['rust-analyzer'] = {
          check = {
            command = "clippy";
          }
        }
      }
    })

  end
}
