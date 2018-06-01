set nocompatible
filetype on
filetype plugin on
syntax on
set ts=4
set sw=4
set ai
set nu
set hlsearch
set expandtab

" automatically install pathogen / plug
if empty(glob('~/.vim/autoload/pathogen.vim'))
    silent !curl -fLo ~/.vim/autoload/pathogen.vim --create-dirs 
        \ https://tpo.pe/pathogen.vim
endif

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! ChompedSystem(...)
    return substitute(call('system', a:000), '\n\+$', '', '')
endfunction

let is_laptop=0
let hostname=ChompedSystem('hostname')
if hostname == 'canopus'
    let is_laptop=1
endif

" Plugin management
execute pathogen#infect()

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/Align'
Plug 'benmills/vimux'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'kien/ctrlp.vim'
if is_laptop == 0 
    Plug 'vim-scripts/Conque-GDB'
else
    Plug 'altercation/vim-colors-solarized'
endif
if v:version >= 800
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'skywind3000/asyncrun.vim'
endif

call plug#end()

runtime! ftplugin/man.vim

let python_highlight_all=1
let c_no_curly_error=1
let $PAGER=''

set tags=./tags,/home/sfortas/git/src/tags
set path+=/home/sfortas/git/src

" Key mappings.
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
nnoremap <c-w><c-]> <c-w>g<c-]>
vnoremap <c-w><c-]> <c-w>g<c-]>
nnoremap <F2> :Grep<CR>
nnoremap <F3> :Regrep<CR>
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-x><C-o>

" Utility functions
function! BuildCPP()
    if v:version >= 800
        if(!empty(glob(expand('%:p:h') . '/Makefile')))
            AsyncRun make -j10
        elseif(!empty(glob(expand('%:p:h') . '/build/Makefile')))
            AsyncRun make -C build -j10
        else
            AsyncRun g++ -g -Wall -pthread -std=c++1y % -o %:r  -lboost_system
        endif
        copen
    else
        let l:old_makeprg=&makeprg
        set makeprg=g++\ -g\ -Wall\ -pthread\ -std=c++1y\ %\ -o\ %:r
        make | cwindow
        set makeprg=l:old_makeprg
    endif
endfunction
command! -nargs=0 Make call BuildCPP()
nnoremap <F9> :Make<CR>

function! Rebuild()
    if v:version >= 800
        if(empty(glob(expand('%:p:h') . '/CMakeLists.txt')))
            echo "No CMakeLists.txt in directory."
            return
        endif
        AsyncRun mkdir -p build; cd build; cmake -DCMAKE_EXPORT_COMPILE_COMMAND=ON -DCMAKE_BUILD_TYPE=Debug ..; make -j10
        copen
    endif
endfunction
function! Build()
    AsyncRun make -C build
    copen
endfunction
command! -nargs=0 Mk call Build()

function! BuildM2()
    if v:version >= 800
        AsyncRun make -C ~/src/dev/M2_Debug
    else
        echo "No AsyncRun in this version"
    endif
endfunction
command! -nargs=0 M2 call BuildM2()

" bufferline
"let g:bufferline_active_buffer_left = '>>'
"let g:bufferline_active_buffer_right = '<<'
"let g:bufferline_echo = 1
"let g:bufferline_inactive_highlight = 'StatusLine'
"let g:bufferline_active_highlight = 'StatusLine'
"let g:bufferline_echo = 0
"autocmd VimEnter *
"    \ let &statusline='%{bufferline#refresh_status()}'
"        \ .bufferline#get_status_string()

"let g:airline_theme='luna'
"let g:airline_theme='dark'
let g:airline_theme='distinguished'
let g:airline_powerline_fonts=1
let g:airline_extensions = ['bufferline']
let g:airline#extensions#bufferline#enabled=1
let g:airline#extensions#bufferline#overwrite_variables=1
let g:airline#extensions#whitespace#enabled=0
set laststatus=2

function! AirlineInit()
    let g:airline_section_z = ''
endfunction
autocmd User AirlineAfterInit call AirlineInit()

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" lsp/cquery
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')

if v:version >= 800 && executable('cquery')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'cquery',
        \ 'cmd': {server_info->['cquery']},
        \ 'root': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \ 'initialization_options': {
        \   'cacheDirectory': '~/.cquery/',
        \   'index': {
        \       'whitelist': ['boost/asio'],
        \       'blacklist': ['usr'],
        \   },
        \ },
        \ 'whitelist': ['c', 'cc', 'cpp', 'objc', 'objcpp'],
        \ })
    autocmd FileType cpp setlocal omnifunc=lsp#complete
    noremap <silent> gd :LspDefinition<CR>
    noremap <silent> <F2> :LspRename<CR>
    noremap <silent> gr :LspReferences<CR>

            " \ 'index': {
            "     \ 'blacklist': [ 'usr', 'boost' ],
            "     \ 'whitelist': [ 'boost/asio' ],
            "     \ 'logSkippedPaths': 1,
            " \ }

noremap <silent> gd :LspDefinition<CR>
noremap <silent> <F2> :LspRename<CR>
noremap <silent> gr :LspReferences<CR>
endif

if is_laptop
    set background=dark
    colorscheme solarized
else
    colorscheme molokai
endif
