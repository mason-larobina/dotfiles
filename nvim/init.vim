set nocompatible

call plug#begin('~/.config/nvim/plugins')

Plug 'easymotion/vim-easymotion'

Plug 'tomasr/molokai'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'neovim/nvim-lspconfig'

Plug 'farmergreg/vim-lastplace'

call plug#end()

colorscheme molokai

runtime work.vim

runtime coc.vim

filetype plugin indent on
syntax on

set number

map Q gqip

let mapleader = "\<Space>"

" Move around splits
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Quick switch buffers
nmap <c-n> :bnext<CR>
nmap <c-p> :bprev<CR>

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
