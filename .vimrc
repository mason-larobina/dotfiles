set title
set hlsearch
set number
set smartcase
set foldmethod=marker
set ts=8 sts=4 sw=4 et
set syntax=on

filetype plugin indent on

nnoremap <silent><F3> :set number!<CR>
noremap <silent><F10> :set spell!<CR>
noremap <silent><F9> :set paste!<CR>

if &t_Co == 256
	colorscheme xoria256
endif
