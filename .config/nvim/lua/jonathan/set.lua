vim.opt.guicursor = ""  -- Always use block cursor.

vim.opt.nu = true  -- Show line numbers.

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
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"

vim.opt.autochdir = true

local setup = [[
    colorscheme slate

    " Show tabs and trailing spaces.
    set list
    set lcs=tab:│┈,trail:·,extends:>,precedes:<,nbsp:&

    " Show line breaks
    set breakindentopt= sbr:...

    " Only one space after a period.
    set nojoinspaces

    " Make ~ an operator.
    set tildeop

    " Go back to the last cursor position after opening a file.
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " hi pythonQuotes ctermfg=59
]]
vim.cmd(setup)
