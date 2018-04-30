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
set noswapfile

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

" Returns output of system() call chomped.
function! ChompedSystem(...)
    return substitute(call('system', a:000), '\n\+$', '', '')
endfunction

" Some variables to change global behavior
let is_laptop=0
let is_work=0
let hostname=ChompedSystem('hostname')
if hostname == 'canopus'
    let is_laptop=1
elseif match(hostname, 'boerboel')
    let is_work=1
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

" Do i need this?
runtime! ftplugin/man.vim

" Language specific settings
let python_highlight_all=1
let c_no_curly_error=1
let $PAGER=''

set tags=./tags,../tags,../../tags,$HOME/git/src/tags
set path+=$HOME/git/src

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
nnoremap <F3> :Grep expand('<cword>') <CR>

" Build related stuff
let g:build_cores=15
if is_laptop
    let g:build_cores=4
endif

let g:gcc_basic_libraries='-lboost_system'
let g:gcc_basic_includes=''
let g:gcc_basic_cmd='g++ -g -Wall -pthread -std=c++1y'

function! BuildMake(where)
    let make_cmd='make -C ' . a:where . ' -j' . g:build_cores
    call asyncrun#run('<bang>', '', make_cmd)
    copen
endfunction

" tries to build using CMake (which sucks).
" 1. create a 'build' directory, and run cmake from it
" 2. run make from build directory.
function! BuildCMake(...)
    let where = get(a:, 1, '.')
    let build = get(a:, 2, 'build')
    let opts = get(a:, 3, '')
    if defines == ''
        call inputsave()
        let opts = input('Additional command line options: ')
        call inputrestore()
    let mkdir_cmd = 'mkdir -p ' . build . '; cd ' . build . ';'
    let cmake_cmd = 'cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON '
        . '-DCMAKE_BUILD_TYPE=Debug ' \
        . opts . '.. ;'
    let make_cmd= 'make -j' . g:build_cores
    call asyncrun#run('<bang>', '', mkdir_cmd . cmake_cmd . make_cmd)
    copen
endfunction

" tries to compile using some standard methods:
" 1. is there is a Makefile in this directory, use it
" 2. if there is a Makefile in ./build/ use that
" 3. if there is a CMakeLists.txt in '.', use that
" 4. otherwise run gcc with basic options on the current file
function! BuildCPP()
    if(filereadable(expand('%:p:h') . '/Makefile')))
        call BuildMake('.')
    elseif(filereadable(expand('%:p:h') . '/build/Makefile')))
        call BuildMake('build')
    elseif(filereadable(expand('%:p:h') . '/CMakeLists.txt')))
        call BuildCMake('.')
    else
        " Basic single file build.
        let build_cmd=g:gcc_basic_cmd . ' ' . g:gcc_basic_includes . ' ' \
            . expand('%') . ' -o ' . expand('%:r') . ' ' \
            . g:gcc_basic_libs
        call asyncrun#run('<bang>', '', build_cmd)
        copen
    endif
endfunction

" tries to rebuild from scratch using standard methods.
" 1. is there is a Makefile here, make clean with it, then run make.
" 2. is there is a build directory with CMakeCache.txt, delete that directory
"    and re-run cmake/make
function! RebuildCPP()
    let dir=expand('%:p:h')
    if(filereadable(dir . '/Makefile'))
        execute "!make clean"
        call BuildCPP()
    elseif (filereadable(dir . '/CMakeLists.txt'))
        " Check if there's a build folder with a cmake cache
        if(filewriteable(dir . '/build/CMakeCache.txt'))
            execute "!rm -r build"
            call BuildCPP()
        endif
    else
        call BuildCPP()
    endif
endfunction

" tries to find and execute (gtest) unit tests in current directory
function! RunUnitTests()
    let tests=split(system('find ' . expand('%:p:h') . ' -name \*_tests -perm /111'), "\n")
    let cmd=''
    for binary in tests
        call inputsave()
        let filt = input('Filter for ' . binary . ': ')
        call inputrestore()
        let cmd = cmd . binary . ' --gtest_shuffle'
        if filt != ''
            let cmd = cmd . ' --gtest_filter=' . filt
        endif
        let cmd = cmd . ';'
        "if first
        "    let first=0
        "    execute "vert term ++close"
        "endif
    endfor
    if cmd == ''
        echo "No tests found."
    else
        call VimuxRunCommand(cmd)
    endif
endfunction

command! -nargs=0 Make call BuildCPP()
command! -nargs=0 Rebuild call RebuildCPP()
command! -nargs=0 UnitTests call RunUnitTests()
nnoremap <F9> :Make<CR>
nnoremap <F10> :Rebuild<CR>
nnoremap <F8> :UnitTests<CR>

if is_work
    function! BuildM2()
        if v:version >= 800
            AsyncRun make -C ~/src/dev/M2_Debug
        else
            echo "No AsyncRun in this version"
        endif
    endfunction
    command! -nargs=0 M2 call BuildM2()
endif

" Utilities
function! DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    execute "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
command! DiffSaved call DiffWithSaved()

" Some mappings/time savers
inoreabbrev email sebastien@fortas.org
inoreabbrev shebang #!/usr/bin/env python
inoreabbrev bang #!/usr/bin/env bash

nnoremap <Leader>sv :execute 'source ~/.vimrc'<CR>

" better tag jumping
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
nnoremap <c-w><c-]> <c-w>g<c-]>
vnoremap <c-w><c-]> <c-w>g<c-]>


" ctrlp
let g:ctrlp_user_command = "find %s -name .git -prune -o -name .svn -prune -o -name CMakeFiles -prune -o -name '_*' -prune -o -type f -not -name '*.cmake' -print"

" Airline
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

" Vimux
let g:VimuxOrientation = "h"
let g:VimuxHeight = "20"
if is_laptop
    let g:VimuxOrientation = "v"
    let g:VimuxHeight = "40"
endif

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" lsp/cquery
" set these to debug cquery
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')

if v:version >= 800 && executable('xcquery')
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
endif

" Colors!
if is_laptop
    set background=dark
    let g:airline_theme='solarized'
    colorscheme solarized
else
    "let g:airline_theme='luna'
    "let g:airline_theme='dark'
    let g:airline_theme='distinguished'
    colorscheme molokai
endif
