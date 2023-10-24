local lsp = require('lsp-zero').preset({})
local configs = require('lspconfig/configs')
local lspconfig = require('lspconfig')

-- vim.tbl_deep_extend('keep', lspconfig, {
--      mojo_lsp_server = {
--          cmd = {'mojo-lsp-server', '--stdio'},
--          filetypes = {'mojo'},
--          name = 'mojo-lsp-server',
--      }
--  })
-- 
-- 
-- configs.mojo_lsp_server = {
--          default_config = {
--              cmd = {'mojo-lsp-server', '--stdio'};
--              filetypes = {'mojo'};
--              root_dir = function(fname)
--                  return lsp.util.find_git_ancestor
--              end;
--              settings = {};
--          };
--      }

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
    lsp.buffer_autoformat()
end)

lsp.ensure_installed({
    'ruff_lsp',
    'rust_analyzer',
    'eslint',
    'texlab',
    'julials',
    'lua_ls',
    'sqlls',
    'jsonls',
    'ltex'
})
-- (Optional) Configure lua language server for neovim
-- Fix Undefined global 'vim'
lsp.nvim_workspace()
-- lsp.setup_servers({"mojo_lsp_server"})

lsp.format_on_save({
    format_opts = {
        async = false, 
        timeout_ms = 10000,
    },
    servers = {
        ["ruff_lsp"] = {"python"}
    }
})


require("lspconfig").ruff_lsp.setup{
    on_attach = on_attach,
    init_options = {
        settings = {
            args = {"--line-length 120"}
        }
    }
}

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-h>'] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)
lsp.setup()
