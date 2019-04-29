" This is a SUPER minimal vim config.
" I use this when on a server, inside a container, breaking stuff, or whatever.
" I'm okay just using `vi` but sometimes I really miss things like `v`
" apk update && apk add vim
" curl (this file's raw github url) to ~/.vimrc

set nu
syntax enable
set shiftwidth=2
set expandtab
set tabstop=2
set nobackup
set nowritebackup
set noswapfile
set linebreak

" recommended python settings from FullstackPython
"
" set autoindent
set cursorline
set showmatch

let python_highlight_all = 1

filetype plugin indent on
au FileType py set textwidth 119  " BSG tweak to PEP8
au FileType py set autoindent

" To indent things after a colon, e.g.
au FileType py set smartindent

" Enable completion where available.
" This setting must be set before ALE is loaded.
let g:ale_completion_enabled = 1


let g:deoplete#enable_at_startup = 1



