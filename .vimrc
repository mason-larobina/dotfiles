" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Backup original files to ~/.vimbak
set backup
set backupdir=~/.vimbak
set directory=~/.vimbak

set history=500         " keep 50 lines of command line history
set showcmd             " display incomplete commands
set incsearch           " match while typing
"set showmatch           " breifly jump to matching brackets on insert
set title               " set the title to something sensible
set hlsearch            " match all find occurances
set number              " show line numbers
set scrolloff=3         " keep 3 lines of context around cursor
set laststatus=2        " always show status line
set ignorecase smartcase " ignore case unless upper chars in search
set autoindent

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set foldmethod=marker

" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
set wildmenu

let mapleader = ","

" Switch syntax highlighting on
" Also switch on highlighting the last used search pattern.
syntax on

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" escape from insert mode with jk or kj
inoremap jk <Esc>
inoremap kj <Esc>

set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo, so
" that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

nnoremap <silent><F3> :set number!<CR>
noremap <silent><F10> :set spell!<CR>
noremap <silent><F9> :set paste!<CR>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

augroup vimrcEx
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

    " Leave the return key alone when in command line windows, since it's used
    " to run commands there.
    autocmd! CmdwinEnter * :unmap <cr>
    autocmd! CmdwinLeave * :call MapCR()
augroup END

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>

" Clear the search buffer when hitting return
function! MapCR()
    nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

if &t_Co == 256
    "colorscheme railscast
    colorscheme myxoria256
endif

"function! SuperCleverTab()
"    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
"        return "\<Tab>"
"    else
"        if &omnifunc != ''
"            return "\<C-X>\<C-O>"
"        elseif &dictionary != ''
"            return "\<C-K>"
"        else
"            return "\<C-N>"
"        endif
"    endif
"endfunction
"inoremap <Tab> <C-R>=SuperCleverTab()<cr>

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Disable arrow keys
map <Left>  <Nop>
map <Right> <Nop>
map <Up>    <Nop>
map <Down>  <Nop>
map <ESC>Od <Nop>
map <ESC>Oc <Nop>
map <ESC>Oa <Nop>
map <ESC>Ob <Nop>

cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

let Tlist_Exit_OnlyWindow=1
let Tlist_Enable_Fold_Column=0
let Tlist_Use_Right_Window=0
let Tlist_Display_Prototype=0
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_WinWidth=30
nnoremap <silent><F8> :TlistToggle<CR>

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%79v.\+/

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>
