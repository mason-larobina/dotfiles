set nocompatible

let mapleader = "\<Space>"

call plug#begin('~/.config/nvim/plugins')

Plug 'easymotion/vim-easymotion'

Plug 'tomasr/molokai'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'neovim/nvim-lspconfig'

Plug 'farmergreg/vim-lastplace'

Plug 'preservim/nerdtree'

Plug 'vim-airline/vim-airline'

Plug 'preservim/nerdtree'

Plug 'dag/vim-fish'

call plug#end()

let g:airline_symbols_ascii = 1

colorscheme molokai

runtime work.vim

runtime coc.vim

syntax enable
filetype plugin indent on

set number
set termguicolors

map Q gqip


" Move around splits
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Quick switch buffers
nmap <c-n> :bnext<CR>
nmap <c-p> :bprev<CR>
nnoremap <leader>d :bdelete<CR>

" Clear search on enter
nnoremap <cr> :nohlsearch<cr>

" C-U in insert mode deletes a lot. Use C-G u to first break undo, so that you
" can undo C-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
