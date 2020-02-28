syntax on

"basic settings
set ai
set guicursor= "disable gui cursor changing
set hlsearch
set ignorecase
set incsearch
set nobackup
set noeb vb t_vb= "disable errorbells and visualbell
set nofixendofline
set number
set relativenumber
set scrolloff=1 "add 1 line of scroll padding on top and bottom
set shiftwidth=2 smarttab
set showcmd
set smartcase
set softtabstop=2 expandtab
set tabstop=2

"filetype settings
filetype plugin indent on

"map leader to space
map <Space> <Leader>

"native vim status line config
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

"ctags search path
set tags=./.tags,.tags;

"gutentags setup
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_file_list_command = {
      \ 'markers': {
      \ '.git': 'git ls-files',
      \ },
      \ }
let g:gutentags_generate_on_new = 1

"toggle tagbar
nmap <C-t> :TagbarToggle<CR>

"open ctrlsf search
nnoremap <C-F> :CtrlSF 

"search highlighted word in file
vnoremap // y/<C-R>"<CR>

"netrw settings
let g:netrw_liststyle=3

"toggle nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"show hidden files in nerdtree
let NERDTreeShowHidden=1

"update all open buffers if external edits
map <C-z> :bufdo :e!<CR>

"fzf fuzzy file search
map <C-p> :FZF<CR>

"use ack.vim with silver_searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

"Disable ALE highlighting
let g:ale_set_highlights = 0

"wildignore config
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

"code folding
set foldmethod=manual

"plugs
call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'NLKNguyen/papercolor-theme'
Plug 'airblade/vim-gitgutter'
Plug 'cespare/vim-toml'
Plug 'dyng/ctrlsf.vim'
Plug 'elzr/vim-json'
Plug 'jaredgorski/spacecamp'
Plug 'junegunn/goyo.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mileszs/ack.vim'
Plug 'neoclide/vim-jsx-improve'
Plug 'pangloss/vim-javascript'
Plug 'sgur/vim-editorconfig'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'w0rp/ale'

call plug#end()

"colorscheme commands
command ColorsDark set background=dark | colorscheme spacecamp
command ColorsLight set background=light | colorscheme PaperColor
command ColorsMed set background=dark | colorscheme spacecamp_lite

"default colorscheme
ColorsDark

