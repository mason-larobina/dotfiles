syntax on
set nocompatible
set ruler
set backspace=indent,eol,start

set backup
set backupdir=~/.vimbak
set directory=~/.vimbak

set history=500
set showcmd " display incomplete commands
set incsearch " jump to search results while typing
set title " set the title to something sensible
set hlsearch " highlight all search results
set number " show line numbers
set scrolloff=3 " keep 3 lines of context around the cursor

set laststatus=2 " always show the last status line

set ignorecase smartcase " ignore case unless upper chars in search pattern

set expandtab
set tabstop=8
set shiftwidth=2
set textwidth=80
set showmode

let g:no_rust_conceal = 1

set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

set foldmethod=marker
set wildmode=longest,list,full
set wildmenu

filetype plugin indent on

inoremap jk <Esc>

map Q gqip

" C-U in insert mode deletes a lot. Use C-G u to first break undo, so that you
" can undo C-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

nnoremap <silent><F3> :set number!<CR>
noremap <silent><F10> :set spell!<CR>
noremap <silent><F9>  :set paste!<CR>

if has('mouse')
  set mouse=a
endif

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nmap <c-n> :bnext<CR>
nmap <c-p> :bprev<CR>

" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>

" Clear the search buffer when hitting return
function! MapCR()
    nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

" Force 256 colors
set t_Co=256
colorscheme myxoria256

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

" Disable arrow keys
map <Left>  <Nop>
map <Right> <Nop>
map <Up>    <Nop>
map <Down>  <Nop>
map <ESC>Od <Nop>
map <ESC>Oc <Nop>
map <ESC>Oa <Nop>
map <ESC>Ob <Nop>
