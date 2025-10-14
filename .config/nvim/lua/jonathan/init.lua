require 'jonathan.set'

vim.g.netrw_banner = 0
vim.g.loaded_matchparen = 1 -- disable built-in MatchParen.
vim.g.netrw_keepdir = 0 -- Change working directory while navigating netrw.

-- Set the leader key
-- (This must happen before plugins are loaded, otherwise wrong leader will be
-- used).
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Install 'lazy' plugin manager.
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- Lazy setup.
require('lazy').setup {
    -- LSP Configuration & Plugins
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Useful status updates for LSP.
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', opts = {} },
        },
        config = function()
            require 'jonathan.lsp'
        end,
    },
    {
        'ray-x/lsp_signature.nvim',
        event = 'VeryLazy',
        opts = {},
        config = function(_, opts)
            -- Show LSP signatures.
            -- See: https://github.com/ray-x/lsp_signature.nvim/tree/master
            require('lsp_signature').setup {
                -- Disable signature float by default, use <C-k> to show.
                floating_window = false,

                -- Show below cursor.
                floating_window_above_cur_line = false,

                -- Don't show the hint.
                hint_enable = false,
            }
        end,
    },
    -- Fuzzy Finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { -- If encountering errors, see telescope-fzf-native README for install instructions
                'nvim-telescope/telescope-fzf-native.nvim',

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = 'make',

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },

            -- Useful for getting pretty icons, but requires a Nerd Font.
            { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
        },
        config = function()
            -- Telescope bindings.
            require('telescope').setup {}
            local builtin = require 'telescope.builtin'
            vim.keymap.set('n', '<leader>f', builtin.find_files, {})
            vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>b', builtin.buffers, {})
            vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
        end,
    },
    -- Treesitter.
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
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
        end,
    },
    -- ChatGPT.
    -- {
    --     'jackMort/ChatGPT.nvim',
    --     event = 'VeryLazy',
    --     config = function()
    --         require('chatgpt').setup()
    --     end,
    --     dependencies = {
    --         'MunifTanjim/nui.nvim',
    --         'nvim-lua/plenary.nvim',
    --         'folke/trouble.nvim',
    --         'nvim-telescope/telescope.nvim',
    --     },
    -- },
    -- Oil file explorer.
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup {}
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        end,
    },
    {
        'github/copilot.vim'
    },
    {
     "CopilotC-Nvim/CopilotChat.nvim",
     dependencies = {
       { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
       { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
     },
     build = "make tiktoken", -- Only on MacOS or Linux
     opts = {
       -- See Configuration section for options
     },
     -- See Commands section for default commands if you want to lazy load on them
    },
    -- Themes.
    {
        'EdenEast/nightfox.nvim',
        config = function()
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
                            string = '#aa0000',
                        },
                    },
                },
            }
        end,
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function() end,
    },
    { 'savq/melange-nvim' },
    { 'ellisonleao/gruvbox.nvim', priority = 1000, config = true, opts = ... },
}

-- vim.cmd.colorscheme 'melange'
-- vim.cmd.colorscheme 'lunaperche'

-- Function to change colorscheme based on 'bg'
local function update_colorscheme()
    if vim.o.background == "dark" then
        vim.cmd("colorscheme rose-pine-moon")
        -- vim.cmd("colorscheme melange")
    else
        vim.cmd("colorscheme lunaperche")
        -- vim.cmd("colorscheme melange")
        -- vim.cmd("colorscheme rose-pine")
        -- vim.cmd [[
        --     hi Normal  guibg=#f0eedd
        -- ]]
    end
end

-- Automatically update colorscheme when 'bg' changes
vim.api.nvim_create_autocmd("OptionSet", {
    pattern = "background",
    callback = update_colorscheme,
})

-- Call the function once to set the initial theme
update_colorscheme()
