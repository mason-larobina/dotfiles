set title
set hlsearch
set number
set smartcase

set foldmethod=marker
filetype plugin indent on

set ts=8 sts=4 sw=4 et

nnoremap <silent><F3> :set number!<CR>
noremap <silent><F10> :set spell!<CR>
noremap <silent><F9> :set paste!<CR>

if &t_Co == 256
	colorscheme xoria256
endif
