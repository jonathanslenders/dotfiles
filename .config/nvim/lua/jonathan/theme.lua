
require('nightfox').setup({
    options = {
        -- transparent = true,
        styles = {
            comments = "italic",
        }
    },
    specs = {
        dayfox = {
            syntax = {
                -- keyword = "#cc00cc",
                -- operator = "#0044ff",
                -- number = "#ff0000",
                string = "#aa0000",
            }
        }
    }
})

vim.cmd("colorscheme dayfox")
-- vim.cmd("colorscheme vim")
vim.opt.bg = 'light' -- set bg=light
