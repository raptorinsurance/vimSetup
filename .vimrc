" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set backupdir=~/.vim/backup

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

set copyindent

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Unmap the arrow keys to break nasty habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Shortcut for NERDTree
command! -nargs=? NE NERDTree <args>

" Searches only case sensitive if capital letters are included
set ignorecase
set smartcase

" Display line numbers
set number

" Move vertically by visual line
nnoremap k gk
nnoremap j gj

" Remap <CR> to clear search highlights
nnoremap <silent> <CR> :noh<CR>

" When a new buffer opened, hide the current one without the need to save
set hidden

" Pathogen for easy plugin management
execute pathogen#infect()

" Solarized colorscheme
set background=dark
colorscheme solarized

" Better tab handling
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4

" Highlight the line the cursor is currently on
set cursorline

" Visual autocomplete for command menu
set wildmenu

" Highlight last inserted text
nnoremap gV `[v`]

" jk is escape
inoremap jk <esc>

" Better key for mapleader
let mapleader=","

" Shortcut for opening change tree and nerd tree
nnoremap <leader>g :GundoToggle<CR>
nnoremap <leader>n :NERDTreeTabsToggle<CR>

" Get gundo to display diff below main window
let g:gundo_preview_bottom=1

" Edit and source vimrc
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Set font
set guifont="Menlo Regular:h12"

" Display buffer names with airline (currently disabled in an attempt to speed
" up lagging vim
let g:airline#extensions#tabline#enabled = 0

" Set up CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Stop NERDTree from opening automatically
let g:nerdtree_tabs_open_on_gui_startup=0

" Prevent the cursor from being at the extreme edges of the screen
set scrolloff=10

" Avoid breaking lines in the middle of words
set linebreak

" Recommended defaults for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Pressing <esc> in multiple cursors mode goes back to normal while keeping
" cursors
" let g:multi_cursor_exit_from_insert_mode=0

" Allow block select to go past end of line
set virtualedit=block

" Easier switching between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" viminfo folder for startify
set viminfo='100,n$HOME/.vim/files/info/viminfo

" Directory for startify session handling
let g:startify_session_dir = '~/.vim/session'

autocmd User Startified setlocal buftype=

" Shortcut for easy buffer deletion without altering window layout (courtesy
" of Bbye)
nnoremap <Leader>q :Bdelete<CR>

" Shortcut to toggle relative number
nnoremap <silent> <Leader>rn :set relativenumber!<CR>
