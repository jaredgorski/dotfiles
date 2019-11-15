" general
set showcmd
filetype indent on
set lazyredraw
set showmatch

" syntax
syntax enable
colorscheme spacecamp

" number
set number
set relativenumber

" tabs
set tabstop=4
set softtabstop=4
" set expandtab

" hl & inc search
set incsearch
set hlsearch
nnoremap noh :nohlsearch<CR>

" folding
set foldenable
set foldlevelstart=99
set foldnestmax=10
set foldmethod=indent

" wildignore
set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" fzf
nnoremap <C-p> :Files<CR>
source /usr/share/doc/fzf/examples/fzf.vim

" plug.vim
call plug#begin()
Plug 'junegunn/fzf.vim'
call plug#end()

