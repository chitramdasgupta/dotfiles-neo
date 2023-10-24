-- Basic setup
vim.o.relativenumber = true
vim.cmd("colorscheme kanagawa")

-- Tree sitter
require'nvim-treesitter.configs'.setup {
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- Lua line
require('lualine').setup()

-- Package management
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Colorscheme
  use "rebelot/kanagawa.nvim"

  -- Tree sitter
  use { 'nvim-treesitter/nvim-treesitter' }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
end)
