-- Leader must be set before lazy.nvim loads
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  spec = {
      {
        "lervag/vimtex",
        lazy = false,     -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
          -- VimTeX configuration goes here, e.g.
          vim.g.vimtex_view_method = vim.fn.has("mac") == 1 and "skim" or "zathura"
          vim.g.vimtex_compiler_latexmk = { out_dir = "build" }
        end
      },
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        keys = {
          { "<leader><leader>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
        },
      },
  },
}

-- Citation autocomplete in LaTeX files
vim.o.completeopt = 'menu,menuone,noselect,popup'
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'tex',
  callback = function()
    vim.opt_local.complete = 'o' -- use VimTeX completion
    vim.opt_local.autocomplete = true
  end,
})

-- custom keybindings
vim.keymap.set('n', '<leader>e', '<cmd>edit .<cr>', { desc = 'Open project explorer' })
