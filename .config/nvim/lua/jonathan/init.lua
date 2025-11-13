-- Install plugins
vim.pack.add {
    -- Utils: plenary is needed by both Telescope and Copilot.vim.
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    -- LSP configurations.
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/ray-x/lsp_signature.nvim' },
    -- Status updates for LSP.
    { src = 'https://github.com/j-hui/fidget.nvim' },
    -- Oil file explorer.
    { src = 'https://github.com/stevearc/oil.nvim' },
    -- Copilot.
    { src = 'https://github.com/github/copilot.vim' },
    { src = 'https://github.com/CopilotC-Nvim/CopilotChat.nvim' },
    -- Telescope.
    { src = 'https://github.com/nvim-telescope/telescope.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },
    -- Treesitter.
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
    -- Themes
    { src = 'https://github.com/savq/melange-nvim' },
    { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
    { src = 'https://github.com/rose-pine/neovim' },
    { src = 'https://github.com/EdenEast/nightfox.nvim' },
}

vim.g.netrw_banner = 0
vim.g.loaded_matchparen = 1 -- disable built-in MatchParen.
vim.g.netrw_keepdir = 0 -- Change working directory while navigating netrw.

-- Set the leader key
-- (This must happen before plugins are loaded, otherwise wrong leader will be
-- used).
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Configure treesitter.
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash',
        'c',
        'html',
        'lua',
        'markdown',
        'vim',
        'vimdoc',
        'python',
        'rust',
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
}

-- Configure file explorer.
require('oil').setup {}
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- Configure nightfox theme.
require('nightfox').setup {
    options = {
        -- transparent = true,
        styles = {
            comments = 'italic',
        },
    },
    specs = {
        dayfox = {
            syntax = {
                -- keyword = "#cc00cc",
                -- operator = "#0044ff",
                -- number = "#ff0000",
                --string = '#aa0000',
            },
        },
    },
}

-- Configure Telescope
require('telescope').setup {}
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})

-- Display code actions in telescope.
require('telescope').load_extension 'ui-select'

require 'jonathan.lsp'
require 'jonathan.set'

-- Function to change colorscheme based on 'bg'
local function update_colorscheme()
    if vim.o.background == 'dark' then
        -- vim.cmd("colorscheme rose-pine-moon")
        vim.cmd.colorscheme 'melange'
    else
        vim.cmd.colorscheme 'lunaperche'
    end
end

-- Automatically update colorscheme when 'bg' changes
vim.api.nvim_create_autocmd('OptionSet', {
    pattern = 'background',
    callback = update_colorscheme,
})

-- Call the function once to set the initial theme
update_colorscheme()
