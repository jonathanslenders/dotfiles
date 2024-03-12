-- Always use block cursor.
vim.opt.guicursor = ''

-- Show line numbers.
vim.opt.nu = true

-- Tab options.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Enable line wrapping.
vim.opt.wrap = true

-- vim.opt.swapfile = false
-- vim.opt.backup = false
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- vim.opt.undofile = true

-- Always highlight search.
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 3
vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 50

vim.opt.termguicolors = true
vim.opt.colorcolumn = '80'

vim.opt.autochdir = true

-- Displaying of whitespace.
-- set list
vim.opt.list = true
-- set lcs=...
vim.opt.listchars = { tab = '│┈', trail = '·', nbsp = '␣' }

-- Configure how new splits should be opened
-- set splitright
vim.opt.splitright = true
-- set splitbelow
vim.opt.splitbelow = true

local setup = [[
    " Show line breaks
    set breakindentopt= sbr:...

    " Only one space after a period.
    set nojoinspaces

    " Make ~ an operator.
    set tildeop

    " Go back to the last cursor position after opening a file.
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " Automatically resize panes when the host resizes. (Like pressing "C-w ="). 
    autocmd VimResized * wincmd =
]]
vim.cmd(setup)
