" ------------------------------
" Jared's Vim                  |
" ++++++++++++++++++++++++++++++


" general
set showcmd
set lazyredraw
set showmatch
set novisualbell
set nofixendofline
set nobackup

" syntax
syntax enable
colorscheme spacecamp

" files
filetype indent on

" number
set number
set relativenumber

" tab and indentation
set ai
set tabstop=2
set softtabstop=2 expandtab
set shiftwidth=2 smarttab
set scrolloff=1

" hl & inc search
set incsearch
set hlsearch
set ignorecase
set smartcase
nnoremap noh :nohlsearch<CR>

" folding
set foldenable
set foldlevelstart=99
set foldnestmax=10
set foldmethod=indent

" netrw
let g:netrw_liststyle=3

" wildignore
set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" disable gui cursor changing
set guicursor=

" status line
set laststatus=2
set statusline=
set statusline+=\ 
set statusline+=%f
set statusline+=%m
set statusline+=%=
set statusline+=\ 
set statusline+=%y
set statusline+=\ 
set statusline+=buf:
set statusline+=%n
set statusline+=\ 
set statusline+=%p%%
set statusline+=\ 
set statusline+=%l:%c
set statusline+=\ 


" ==============================
" KEY BINDINGS
" ==============================

" map leader to space
map <Space> <Leader>

" search highlighted word in file with double-slash
vnoremap // y/<C-R>"<CR>

" update all open buffers if external edits
map <C-z> :bufdo :e!<CR>

" ctrlsf
nnoremap <C-F> :CtrlSF

" fzf
map <C-p> :Files<CR>


" ==============================
" PLUG.VIM
" ==============================

call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'dyng/ctrlsf.vim'
Plug 'elzr/vim-json'
Plug 'jaredgorski/spacecamp'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'neoclide/vim-jsx-improve'
Plug 'pangloss/vim-javascript'
Plug 'sgur/vim-editorconfig'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'dense-analysis/ale'

call plug#end()
