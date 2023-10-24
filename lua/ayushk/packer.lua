-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use({
        "bluz71/vim-moonfly-colors",
        as = "moonfly",
        config = function()
            vim.cmd('colorscheme moonfly')
        end
    })

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('theprimeagen/harpoon')
    use('tpope/vim-fugitive')
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }
   use('github/copilot.vim')
   use({'vimwiki/vimwiki', config = function()
       vim.g.vimwiki_list = {
           {
               path = '~/Dropbox/Notes',
               syntax = 'markdown',
               ext = '.md',
           }
       }
   end})

   use({
       "andrewferrier/wrapping.nvim",
       config = function()
           require("wrapping").setup()
       end})
       use({
           "epwalsh/obsidian.nvim",
           requires = {
               -- Required.
               "nvim-lua/plenary.nvim",

               -- see below for full list of optional dependencies 👇
           },
           config = function()
               require("obsidian").setup({
                   dir = "~/Dropbox/Notes",

                   -- see below for full list of options 👇
               })
           end,
       })

    use({
        "quarto-dev/quarto-nvim",
        requires = {
            'jmbuhr/otter.nvim'
        },
        config = function()
            require("quarto").setup({
                -- see below for full list of options 👇
            })
        end,
    })

    use({"Vigemus/iron.nvim"})

end)
