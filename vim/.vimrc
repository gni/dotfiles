" ----------------------------------------------------------------------------
"  Vim-Plug
" ----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Appearance
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File navigation
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git integration
Plug 'tpope/vim-fugitive'

" Syntax and autocompletion
Plug 'sheerun/vim-polyglot' " A solid language pack
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Quality of life
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'

call plug#end()


" ----------------------------------------------------------------------------
"  General
" ----------------------------------------------------------------------------
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " convert tabs to spaces
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " set an 80 column border for good coding style
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set clipboard=unnamedplus   " uses the system clipboard


" ----------------------------------------------------------------------------
"  Theme
" ----------------------------------------------------------------------------
set background=dark
let g:gruvbox_contrast_dark = 'hard'
silent! colorscheme gruvbox

" Airline
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1


" ----------------------------------------------------------------------------
"  Key Mappings
" ----------------------------------------------------------------------------
" NERDTree
map <C-n> :NERDTreeToggle<CR>

" FZF
map <C-p> :Files<CR>


" ----------------------------------------------------------------------------
"  CoC (Auto-completion)
" ----------------------------------------------------------------------------
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
