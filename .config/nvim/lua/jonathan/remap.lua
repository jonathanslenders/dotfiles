vim.keymap.set("i", "<C-s>", "<C-x><C-o>") -- Insert mode omni completion.


vim.keymap.set({ 'i' }, '<C-k>', function()
    require('lsp_signature').toggle_float_win()
end)

--vim.keymap.set({ 'i' }, '<C-o>', function()
--     vim.lsp.buf.signature_help()
--end)

