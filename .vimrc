" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Enhance command-line completion
set wildmenu

" Allow cursor keys in insert mode
set esckeys

" Allow backspace in insert mode
set backspace=indent,eol,start

" Optimize for fast terminal connections
set ttyfast

" Add the g flag to search/replace by default
"set gdefault

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Change mapleader
let mapleader=","

" Don’t add empty newlines at the end of files
set binary
set noeol

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif

" Respect modeline in files
set modeline
set modelines=4

" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure

" Enable syntax highlighting
syntax on

" Highlight current line
set cursorline

" Show “invisible” characters
"set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set lcs=tab:▸\ ,trail:·,nbsp:_
set list

" Highlight searches
set hlsearch

" Ignore case of searches
set ignorecase

" Highlight dynamically as pattern is typed
set incsearch

"------
" Always show status line
set laststatus=2

" Enable mouse in all modes
"set mouse=a

" Disable error bells
set noerrorbells

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Show the cursor position
set ruler

" Don’t show the intro message when starting Vim
set shortmess=atI

" Show the current mode
set showmode

" Show the filename in the window titlebar
set title

" Show the (partial) command as it’s being typed
set showcmd

" Enable line numbers
"set number

" Use relative line numbers
if exists("&relativenumber")
    set relativenumber
    au BufReadPost * set relativenumber
endif

" Toggle function to switch between relative and absolute numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

" Automatically set abs numbering when inserting
autocmd InsertEnter * :set number

" Automatically go to relative numbering when leaving insert mode
autocmd InsertLeave * :set relativenumber

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

filetype plugin indent on
" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype on
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif

" I like 4 space indents
set sw=4
set ts=4
set softtabstop=4
set expandtab

set nofoldenable
" We should try folding
" set foldmethod=indent

"set ai

set background=dark
set pastetoggle=<F2>

" remove trailing spaces with F5
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Show trailing spaces
"highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
"match ExtraWhitespace /\s\+$/

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"autocmd BufWinLeave * call clearmatches()

highlight MixedTabsAndSpaces ctermbg=darkgray guibg=darkgray
match MixedTabsAndSpaces /^[ \t]+[^\s]+/
autocmd BufWinEnter * match MixedTabsAndSpaces /^[ \t]+[^\s]+/
autocmd InsertEnter * match MixedTabsAndSpaces /^[ \t]+[^\s]+\%#\@<!$/
autocmd InsertLeave * match MixedTabsAndSpaces /^[ \t]+[^\s]+/
autocmd BufWinLeave * call clearmatches()

highlight MatchParen cterm=bold ctermfg=white ctermbg=black

set history=50		" keep 50 lines of command line history
set showcmd		    " display incomplete commands

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq


 set rtp+=~/.vim/bundle/vundle/
 call vundle#rc()

 " let Vundle manage Vundle
 " required! 
 Bundle 'gmarik/vundle'

 " My Bundles here:
 "
 " original repos on github
Bundle 'majutsushi/tagbar'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
"Bundle 'tpope/vim-fugitive'
"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'tpope/vim-rails.git'
" vim-scripts repos
"Bundle 'L9'
"Bundle 'FuzzyFinder'
" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
" ...

 filetype plugin indent on     " required!
 "
 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..

map <F8> :TagbarToggle<CR>

map <C-n> :NERDTreeToggle<CR>
let NERDTreeDirArrows=1

let g:ctrlp_map = '<Leader>p'
nmap <silent> <Leader>pp :CtrlPTag<CR>
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files']
