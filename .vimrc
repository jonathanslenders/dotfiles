set nocompatible

" Open files using utf-8 by default instead of latin-1
" See: https://unix.stackexchange.com/questions/23389/how-can-i-set-vims-default-encoding-to-utf-8/23414
set encoding=utf-8

" Disable modelines (prevent arbitrary code execution via modelines).
set nomodeline

" Syntax highlighting on
syntax on

" Line numbers
set number

" Highlight search
set hlsearch
set incsearch

" Indentation (4 spaces)
set tabstop=4
set shiftwidth=4
set expandtab

" Automatically load indent rules according to file type.
filetype indent on

" Show tabs and trailing spaces.
set list
set lcs=tab:│┈,trail:·,extends:>,precedes:<,nbsp:&

" Show line breaks
set breakindentopt= sbr:...

" Use system clipboard by default
set clipboard=unnamed

" Custom key bindings.
imap jj <esc>
imap hh <esc>

" Pretty command-line option matching.
set wildmenu

" Always keep three lines above or below the cursor.
set scrolloff=3

" Show the cursor position all the time.
set ruler

" Only one space after a period.
set nojoinspaces

" Make ~ an operator.
set tildeop

" Vertical lines.
"set colorcolumn=80
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235

" Molokai color scheme.
"colorscheme molokai
"colorscheme default

" Use Solarized, dark, but don't set any background
" color. Let tmux take care of background colors.
colorscheme solarized8_low
set background=dark
highlight Normal ctermbg=none

" Selection color.
highlight Visual ctermbg=230

" Don't erase the background color.
" See: https://sunaku.github.io/vim-256color-bce.html
set t_ut=

" Save certain things when exiting. (Should be after 'set nocompatible'.)
set viminfo=%,<800,'100,/100,:100,h,f0,n~/.vim/viminfo
"           | |    |    |    |    | |  + viminfo file path
"           | |    |    |    |    | + file marks 0-9,A-Z 0=NOT stored
"           | |    |    |    |    + disable 'hlsearch' loading viminfo
"           | |    |    |    + command-line history saved
"           | |    |    + search history saved
"           | |    + files marks saved
"           | + lines saved each register (old name for <, vi6.2)
"           + save/restore buffer list

" Go back to the last cursor position after opening a file.
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" Automatically move the current working directory to the opened file.
set autochdir

" When splitting, open the new window on the right/bottom.
set splitright
set splitbelow

" Automatically resize panes when the host resizes. (Like pressing "C-w =").
autocmd VimResized * wincmd =

hi pythonQuotes ctermfg=59
