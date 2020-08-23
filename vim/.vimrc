"~~~~~~~~~~~~~~~~~~~~~~
"       general
"~~~~~~~~~~~~~~~~~~~~~~
syntax on

"basic settings
set nocompatible
set ai
set ignorecase
set hlsearch
set incsearch                               "allow incremental search
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set noeb vb t_vb=                           "disable errorbells and visualbell
set number
set relativenumber
set scrolloff=1                             "add 1 line of scroll padding on top and bottom
set shiftwidth=2 smarttab
set showcmd
set signcolumn=yes
set smartcase
set softtabstop=2 expandtab
set tabstop=2
set foldmethod=manual                       "code folding
if has("wildmenu")
  set wildmenu
  set wildmode=longest:full,full
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip  "wildignore path
endif

filetype plugin indent on                   "filetype settings

set tags=./.tags,.tags;                     "ctags search path

"~~~~~~~~~~~~~~~~~~~~~~
"     status line
"~~~~~~~~~~~~~~~~~~~~~~
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

"~~~~~~~~~~~~~~~~~~~~~~
"        netrw
"~~~~~~~~~~~~~~~~~~~~~~
let g:netrw_liststyle=1

"~~~~~~~~~~~~~~~~~~~~~~
"       mappings
"~~~~~~~~~~~~~~~~~~~~~~
"map leader to space
map <Space> <leader>

"ctrlsf search
nnoremap <leader>f :CtrlSF 

"search highlighted word in file - extends * and # to work with visual
vnoremap * y/<C-R>"<CR>
vnoremap # y?<C-R>"<CR>

"update all open buffers if external edits
map <leader>z :bufdo :e!<CR>

"fzf fuzzy file search
map <leader>p :FZF<CR>

"~~~~~~~~~~~~~~~~~~~~~~
"       plugins
"~~~~~~~~~~~~~~~~~~~~~~
"plugs
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'cespare/vim-toml'
Plug 'dyng/ctrlsf.vim'
Plug 'jaredgorski/fogbell.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'neoclide/vim-jsx-improve'
Plug 'pangloss/vim-javascript'
Plug 'sgur/vim-editorconfig'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'vimwiki/vimwiki'
Plug 'w0rp/ale'

call plug#end()

"~~~~~~~~~~~~~~~~~~~~~~
"    plugin settings
"~~~~~~~~~~~~~~~~~~~~~~
"dyng/ctrlsf.vim
let g:ctrlsf_auto_focus = { "at": "start" }               "autofocus ctrlsf results
let g:ctrlsf_search_mode = 'async'                        "enables async search

"w0rp/ale
let g:ale_set_highlights = 0                              "disable ALE highlighting

"~~~~~~~~~~~~~~~~~~~~~~
"    vimwiki settings
"~~~~~~~~~~~~~~~~~~~~~~
autocmd FileType vimwiki set autochdir                    "enable direct filename autocompletion within vimwiki directory

" Notes search
command! -bang -nargs=* WikiRg call fzf#vim#grep('rg 
      \ --column --line-number --no-heading --color=never 
      \ --smart-case --type md <q-args> "/Users/jaredgorski/vimwiki"',
      \ 1, fzf#vim#with_preview(), <bang>0)
autocmd FileType vimwiki nnoremap <buffer> <leader>wf :WikiRg<Space>

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

"~~~~~~~~~~~~~~~~~~~~~~
"       colors
"~~~~~~~~~~~~~~~~~~~~~~
syntax on
colorscheme fogbell
set t_Co=256
