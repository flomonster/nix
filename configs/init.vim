syntax on
set nocompatible
set tabstop=2
set shiftwidth=2
set cc=80
set expandtab
set list listchars=tab:\|\-
set smartindent
set ruler
set mouse=a
set number
set clipboard+=unnamedplus
set noswapfile

set showcmd
set showmatch
set showmode
set formatoptions+=o
set modeline
set linespace=0
set magic
set foldlevel=99

" Allow to search recursively when using :find
set path=.,**

" Autocomplete :f with :find
cabbrev f find

" Remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Scrolling
if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif

"  /-------------------\
" |       PLUGINS       |
"  \-------------------/

" Linting
" Run neoamke automatically
autocmd VimEnter * call neomake#configure#automake('nw', 750)

" Deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = "/usr/lib/libclang.so"
let g:deoplete#sources#clang#clang_header = "/usr/lib/clang"
set completeopt-=preview

" Racer
set hidden
let g:racer_cmd = "/home/flomonster/.cargo/bin/racer"

" Neoformat
map <Space> :Neoformat<CR>:w<CR>

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c' ],
    \ [ 'x', 'y', 'z' ]]


"  /-------------------\
" |      BINDINGS       |
"  \-------------------/

" Enter call :make command
map <Enter> :make<CR><CR>

" Bind Buffer
" Switch of buffer using tab (like firefox)
map <Tab> :bn<CR>
map <S-Tab> :bp<CR>
" Switch of buffer using ctrl+n or ctrl+b
map <C-n> :bn<CR>
map <C-b> :bp<CR>
" Quit a bugger with ctrl+q
map <C-q> :bp<bar>sp<bar>bn<bar>bd<CR>

" Bind Tiles
" Used to move between buffers without W
map <C-l> <C-W>l
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
