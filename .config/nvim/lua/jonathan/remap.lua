-- Set leader.
local setup = [[
    let mapleader=","
]]
vim.cmd(setup)

-- Insert mode omni completion.
vim.keymap.set("i", "<C-s>", "<C-x><C-o>")

-- Toggle signature.
vim.keymap.set({ 'i' }, '<C-k>', function()
    require('lsp_signature').toggle_float_win()
end)

--vim.keymap.set({ 'i' }, '<C-o>', function()
--     vim.lsp.buf.signature_help()
--end)

-- Telescope.
require('telescope').setup{ }
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})

-- Harpoon.
-- require('harpoon').setup({
--     tabline = false,
--     tabline_prefix = '   ',
--     tabline_suffix = '   ',
-- })
-- vim.keymap.set('n', '<leader>ha', require("harpoon.mark").add_file, {})
-- vim.keymap.set('n', '<leader>hm', require("harpoon.ui").toggle_quick_menu, {})
-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- 
-- vim.keymap.set('n', '<leader>m', function()
--     vim.cmd("Telescope harpoon marks")
-- end)
-- 
-- 
-- require("telescope").load_extension('harpoon')
