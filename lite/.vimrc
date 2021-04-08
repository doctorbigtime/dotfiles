" Section: Options {{{
" --------------------
set nocompatible
filetype on
filetype plugin on
syntax on

set ts=2       " tabs are 2 columns
set sw=2       " number of spaces to insert for reindent
set shiftround " round indent to next multiple of sw
set expandtab  " turn tabs into spaces
set ai         " autoindent
set number     " show line numbers
set tw=0       " no maximum line length by default
"set relativenumber " set line numbering relative to current line

set cursorline " highlight current line
set hlsearch   " highlight searches
set ignorecase " ignore case while searching
set smartcase  " ...unless there is a capital letter
set noswapfile

set autowrite  " write before :make and :next

" Make spacebar work like :
noremap <space> :

set showcmd     " show commands.
set cmdheight=2 " show 2 lines of commands

set lazyredraw  " don't redraw during macros
set ff=unix     " unix file format

set showmatch   " show matching brackets
set matchtime=1 " ... for 0.1 seconds

" do not show invisible characters
set nolist
" toggle invisible characters
nnoremap <Leader>i :set list!<cr>
" map invisible characters to these. 
set listchars=tab:▸\ ,eol:¬,trail:.,extends:»,precedes:«,nbsp:.

" }}}
" Section: Variables {{{
" ----------------------

" }}}
" Section: Plugins {{{
" --------------------

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'chrisbra/csv.vim'

call plug#end()

" }}}
" Section: Functions {{{
" ----------------------

" Searching
function! DoRGrep(...)
    if a:0 == 0
       call inputsave()
       let query=input('Query: ')
       call inputrestore()
    else
        let query=a:1
    endif
    let grep_cmd='egrep --exclude-dir={.git,.svn,.cquery,CMakeFiles} -I -r -n '
    call asyncrun#run('<bang>', '', grep_cmd . '"' . query . '"')
    copen
endfunction
command! -nargs=? Grep call DoRGrep(<args>)
nnoremap <Leader>f :Grep expand('<cword>') <CR>

" }}}
" Section: Misc commands and maps {{{
" -----------------------------------

" global find/replace
nnoremap <F4> :%s/<c-r><c-w>//g<LEFT><LEFT>

" better tag jumping
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
" better new window tag jumping. 
nnoremap <c-w><c-]> <c-w>g<c-]>
vnoremap <c-w><c-]> <c-w>g<c-]>

" For communicating between vim instances...
function! Paste()
    r ~/tmp/.vim.copy
endfunction

function! Copy(line1, line2)
    silent! exe a:line1 .',' . a:line2 . 'w! ~/tmp/.vim.copy'
endfunction

function! Cut(line1, line2)
    call Copy(a:line1, a:line2)
    exe a:line1 . ',' . a:line2 . 'd'
endfunction

command! -range   Y  call Copy(<line1>, <line2>)
command! -range   YD call Cut(<line1>, <line2>)
command! -nargs=0 P  call Paste()
nnoremap <silent> <Leader>p :call Paste()<cr>
vnoremap <leader>y "yy <bar> :call system('xclip -in -selection clipboard', @y)<cr>

nnoremap <leader>dg :diffget<cr>

function! SwapComment()
    :Commentary
    normal j
    :Commentary
endfunction
command! SC call SwapComment()<cr>

function! DuplicateAndComment()
    normal yyp
    normal k
    :Commentary
    normal j
endfunction
command! DC call DuplicateAndComment()<cr>

" }}}
" Section: Colors! {{{
" --------------------
set termguicolors
colorscheme gotham256

" }}}
