return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require('bufferline')
    vim.opt.termguicolors = true
    opts = {
      options = {
        numbers = "buffer_id",
      },
    }
    bufferline.setup(opts)
  end
}
