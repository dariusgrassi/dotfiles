call plug#begin('~/.vim/plugged')
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'preservim/nerdtree'
call plug#end()

" Configs for TeX preview
autocmd Filetype tex setl updatetime=1000
let g:livepreview_previewer = 'evince'

" aesthetic configs
set backspace=indent,eol,start
set t_Co=256
set background=dark
set number
set numberwidth=1
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
nnoremap <Up> :echo "No up"<CR>
vnoremap <Up> :<C-u>echo "No up"<CR>
inoremap <Up> <C-o>:echo "No up"<CR>
nnoremap <Down> :echo "No down"<CR>
vnoremap <Down> :<C-u>echo "No down"<CR>
inoremap <Down> <C-o>:echo "No down"<CR>
nnoremap <Left> :echo "No left"<CR>
vnoremap <Left> :<C-u>echo "No left"<CR>
inoremap <Left> <C-o>:echo "No left"<CR>
nnoremap <Right> :echo "No right"<CR>
vnoremap <Right> :<C-u>echo "No right"<CR>
inoremap <Right> <C-o>:echo "No right"<CR>
