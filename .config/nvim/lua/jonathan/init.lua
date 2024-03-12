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
vim.cmd.colorscheme 'lunaperche'

-- Toggle between dark/light mode.
local isDarkPath = os.getenv 'HOME' .. '/.config/nvim/is-dark'

function set_dark_mode()
    vim.opt.bg = 'dark' -- set bg=dark

    local file = io.open(isDarkPath, 'w')
    file:write(tostring(true))
    file:close()
end
function set_light_mode()
    vim.opt.bg = 'light' -- set bg=light
    vim.cmd [[
        hi Normal  guibg=#f0eedd
    ]]

    local file = io.open(isDarkPath, 'w')
    file:write(tostring(false))
    file:close()
end
function isDark()
    local file = io.open(isDarkPath, 'r')
    if file then
        local content = file:read '*all'
        file:close()
        return content == 'true'
    end
    return false
end
function toggle_dark_mode()
    if isDark() then
        set_light_mode()
    else
        set_dark_mode()
    end
end
function set_dark_mode_according_to_file()
    if isDark() then
        set_dark_mode()
    else
        set_light_mode()
    end
end

local timer = vim.uv.new_timer()
timer:start(0, 3000, vim.schedule_wrap(set_dark_mode_according_to_file))

vim.keymap.set({ 'n', 'i' }, '<C-s>', function()
    toggle_dark_mode()
end)
