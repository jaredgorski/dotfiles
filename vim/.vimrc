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
map <Space> <leader>

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
nmap <leader>t :TagbarToggle<CR>

"open ctrlsf search
nnoremap <leader>f :CtrlSF 

"search highlighted word in file - extends * and # to work with visual
vnoremap * y/<C-R>"<CR>
vnoremap # y?<C-R>"<CR>

"netrw settings
let g:netrw_liststyle=1

"netrw toggle function and mapping
function ToggleNetrw()
  if &filetype == 'netrw'
    if expand('#:t') != ''
      execute "bprevious"
    else
      execute "Rexplore"
    endif
  elseif expand('%:t') != ''
    execute "Explore %:h"
  else
    execute "Explore"
  endif
endfunction
map <leader>n :call ToggleNetrw()<CR>

"update all open buffers if external edits
map <leader>z :bufdo :e!<CR>

"fzf fuzzy file search
map <leader>p :FZF<CR>

"Disable ALE highlighting
let g:ale_set_highlights = 0

"wildignore config
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

"code folding
set foldmethod=manual

"plugs
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'cespare/vim-toml'
Plug 'dyng/ctrlsf.vim'
Plug 'elzr/vim-json'
Plug 'jaredgorski/fogbell.vim'
Plug 'jaredgorski/spacecamp'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neoclide/vim-jsx-improve'
Plug 'pangloss/vim-javascript'
Plug 'sgur/vim-editorconfig'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'w0rp/ale'

call plug#end()

"colorscheme commands
command ColschemeDark syntax on | colorscheme spacecamp
command ColschemeLight syntax on | colorscheme fogbell_light
command ColschemeMed syntax on | colorscheme spacecamp_lite
command ColschemeMono syntax on | colorscheme fogbell
command ColschemeMonoMono colorscheme fogbell | syntax off
command ColschemeMonolite syntax on | colorscheme fogbell_lite
command ColschemeMonoliteMono colorscheme fogbell_lite | syntax off

"default colorscheme
ColschemeMono

