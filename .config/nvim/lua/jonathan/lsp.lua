-- See: https://github.com/neovim/nvim-lspconfig/tree/54eb2a070a4f389b1be0f98070f81d23e2b1a715#suggested-configuration
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Show inline diagnostics alongside the code.
vim.diagnostic.config { virtual_text = true }

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        -- Also complete using Control-S
        vim.keymap.set('i', '<C-s>', '<C-x><C-o>')

        -- Toggle signature.
        vim.keymap.set({ 'i' }, '<C-k>', function()
            require('lsp_signature').toggle_float_win()
        end)

        --vim.keymap.set({ 'i' }, '<C-o>', function()
        --     vim.lsp.buf.signature_help()
        --end)

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, bufopts)
    end,
})

require('lsp_signature').setup {
    -- Disable signature float by default, use <C-k> to show.
    floating_window = false,

    -- Show below cursor.
    floating_window_above_cur_line = false,

    -- Don't show the hint.
    hint_enable = false,
}

vim.lsp.enable 'stylua'

-- Configure `ruff`.
vim.lsp.enable 'ruff'

-- Use the Jedi language server for code completion and navigation to
-- definitions. Requires: `pip install jedi-language-server`.
vim.lsp.enable('typos_lsp', {
    diagnosticSeverity = 'Warning',
})

-- Use the Jedi language server for code completion and navigation to
-- definitions. Requires: `pip install jedi-language-server`.
vim.lsp.enable 'jedi_language_server'
-- vim.lsp.enable('zuban', { })

-- Rust
vim.lsp.enable('rust_analyzer', {
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = false,
            },
        },
    },
})

-- Javascript formatting. (Requires `npm install -g @biomejs/biome`).
vim.lsp.enable 'biome'

vim.cmd [[
    " No border background around float.
    highlight FloatBorder  ctermfg=NONE ctermbg=NONE cterm=NONE

    " Don't show the "Scratch preview buffer" when completing Rust code.
    set completeopt-=preview
]]
