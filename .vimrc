call plug#begin('~/.vim/plugged')
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'shime/vim-livedown'
Plug 'preservim/nerdtree'
call plug#end()

" Configs for TeX preview
autocmd Filetype tex setl updatetime=1000
let g:livepreview_previewer = 'evince'
au FileType latex setlocal tw=72
au FileType latex setlocal spell

" Configs for Markdown preview
let g:livedown_autorun = 0
au FileType markdown setlocal tw=72
au FileType markdown setlocal spell

" aesthetic configs
set backspace=indent,eol,start
set t_Co=256
set background=dark
set number
set numberwidth=1
set tabstop=4
set ruler
set hlsearch
set timeoutlen=1000 ttimeoutlen=0
set relativenumber
colo earthburn
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE
hi clear SpellBad
hi Search cterm=NONE ctermfg=black ctermbg=cyan
hi SpellBad cterm=underline ctermfg=red

" Disabling vim arrow keys
nnoremap <Up> :echo ""<CR>
vnoremap <Up> :<C-u>echo ""<CR>
inoremap <Up> <C-o>:echo ""<CR>
nnoremap <Down> :echo ""<CR>
vnoremap <Down> :<C-u>echo ""<CR>
inoremap <Down> <C-o>:echo ""<CR>
nnoremap <Left> :echo ""<CR>
vnoremap <Left> :<C-u>echo ""<CR>
inoremap <Left> <C-o>:echo ""<CR>
nnoremap <Right> :echo ""<CR>
vnoremap <Right> :<C-u>echo ""<CR>
inoremap <Right> <C-o>:echo ""<CR>
