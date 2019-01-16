" Section: Options {{{
" --------------------
set nocompatible
filetype on
filetype plugin on
syntax on

set ts=4       " tabs are 4 columns
set sw=4       " number of spaces to insert for reindent
set shiftround " round indent to next multiple of sw
set expandtab  " turn tabs into spaces
set ai         " autoindent
set number     " show line numbers
set tw=0       " no maximum line length by default
"set relativenumber " set line numbering relative to current line

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

" Some directories
let g:source_roots=[$HOME . '/git/src']
if is_work
let g:source_roots=[$HOME . '/src/vplat', $HOME . '/src/marcrepo/greyhound']
endif

set tags=./tags,../tags,../../tags,$HOME/git/src/tags
let path='.,../include,./include,' . join(g:source_roots, ',') . ',/usr/include'


" }}}
" Section: Plugins {{{
" --------------------

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/Align'
Plug 'benmills/vimux'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chrisbra/csv.vim'
Plug 'bling/vim-bufferline'
if v:version >= 800
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'skywind3000/asyncrun.vim'
endif
if is_laptop
    Plug 'altercation/vim-colors-solarized'
elseif is_work
    Plug 'juneedahamed/svnj.vim'
endif
Plug 'SirVer/ultisnips'

call plug#end()

" ULTISNIPS
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" Do i need this?
runtime! ftplugin/man.vim

" Language specific settings
let python_highlight_all=1
let c_no_curly_error=1
let $PAGER=''
" }}}
" Section: Autocmds {{{
" ---------------------
autocmd BufReadPost ~/.Xresources call system('xrdb -load ' . expand('%'))

augroup ft_options
    autocmd!
    autocmd FileType cpp    setlocal commentstring=//\ %s
augroup END

augroup hl_todos
    au!
    au BufNewFile,BufRead *.cpp,*.h,*.hpp,*.cc syn match cppTodo "\<\(TODO\|FIXME\|XXX\):"
    au BufNewFile,BufRead ~/.vimrc,*.vim syn match vimTodo "\<\(TODO\|FIXME\|XXX\|FOOBAR\):"
augroup END

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

function! DoAg(...)
    if a:0 == 0
       call inputsave()
       let query=input('Query: ')
       call inputrestore()
    else
        let query=a:1
    endif
    let s:cmd='ag --cpp --vimgrep "' . query . '" ' . join(g:source_roots, ' ')
    "call asyncrun#run('<bang>', '', s:cmd)
    "copen
    " TODO: run asynchronously, but put output into fzf window.
    call fzf#run({'source': s:cmd, 'down': '25%', 'sink': function('EditGrepOutput')})
endfunction
command! -nargs=? Ag call DoAg(<args>)
nnoremap <Leader>a :Ag expand('<cword>') <CR>

function! EditGrepOutput(what)
    let [fn, line] = split(a:what, ':')[:1]
    execute "edit +" . line . " " . fnameescape(fn)
endfunction

function! TypeDef(typename)
    let s:cmd = 'ag --cpp --vimgrep "(struct|class)( +V.._DECLARE_EXPORT)? +' . a:typename . '" ' . join(g:source_roots, ' ')
    call fzf#run({'source': s:cmd, 'down': '25%', 'sink': function('EditGrepOutput')})
endfunction
noremap <Leader>gt :call TypeDef(expand('<cword>'))<CR>
command! -nargs=1 TD :call TypeDef(<f-args>)<CR>

" Build related stuff
let g:build_cores=15
if is_laptop
    let g:build_cores=4
endif

"let g:gcc_basic_libraries='-lboost_system'
let g:gcc_basic_libraries='-lboost_system'
let g:gcc_basic_includes=''
let g:gcc_basic_cmd='g++ -g -Wall -pthread -std=c++17'

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
    let mkdir_cmd = 'mkdir -p ' . build . '; cd ' . build . ';'
    let cmake_cmd = 'cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON '
                \ . '-DCMAKE_BUILD_TYPE=Debug '
                \ . opts . '.. ;'
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
    if(filereadable(expand('%:p:h') . '/Makefile'))
        call BuildMake('.')
    elseif(filereadable(expand('%:p:h') . '/build/Makefile'))
        call BuildMake('build')
    elseif(filereadable(expand('%:p:h') . '/CMakeLists.txt'))
        call BuildCMake('.')
    else
        " Basic single file build.
        let build_cmd=g:gcc_basic_cmd . ' ' . g:gcc_basic_includes . ' '
                    \ . expand('%') . ' -o ' . expand('%:r') . ' '
                    \ . g:gcc_basic_libraries
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

" Utilities
function! DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    execute "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
command! DiffSaved call DiffWithSaved()

function! s:googleIt(pat)
    let q = '"' . substitute(a:pat, '["\n]', ' ', 'g') . '"'
    let q = substitute(q, '[[:punct:]]', '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
    echo printf('mimeopen "https://www.google.com/search?q=%s"', q)
endfunction
nnoremap <silent> <Leader>? :call <SID>googleIt(expand("<cWORD>"))<cr>

" This diffs the working version of a file with the latest svn commited version.
function! DiffWithSVN()
    let filetype=&ft
    diffthis
    vnew | r! svn cat #
    normal! 1Gdd
    diffthis
    execute "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
command! DiffSVN call DiffWithSVN()

" }}}
" Section: Misc commands and maps {{{
" -----------------------------------

" Sort alphabetically ignoring case
nnoremap <Leader>sa :sort i<cr>

" Make a scratch pad
command! -bar -nargs=? -bang PB :silent enew<bang>|set buftype=nofile bufhidden=hide nonu noswapfile buflisted filetype=<args>
command! -bar -nargs=? -bang Scratch :silent split| enew<bang>|set buftype=nofile bufhidden=hide noswapfile buflisted filetype=<args>
command! -bar -nargs=? -bang Write :silent enew<bang>|set spell textwidth=66 formatoptions=tacqwn noswapfile buflisted filetype=txt nonu

" global find/replace
nnoremap <F4> :%s///g<LEFT><LEFT><LEFT>

" edit .vimrc
nnoremap <Leader>ev :e ~/.vimrc<CR>
" reload .vimrc
nnoremap <Leader>sv :execute 'source ~/.vimrc'<CR>

" better tag jumping
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
" better new window tag jumping. 
nnoremap <c-w><c-]> <c-w>g<c-]>
vnoremap <c-w><c-]> <c-w>g<c-]>

" Do i need this?
runtime! ftplugin/man.vim

" Some mappings/time savers
inoreabbrev pybang  #!/usr/bin/env python
inoreabbrev shebang #!/usr/bin/env bash
inoreabbrev teh the

" Section: Experiment {{{
" -----------------------
" FIXME
function! s:HiInterestingWord(n)
    normal! mz
    normal! "zyiw
    let mid = 86750 + a:n
    silent! call matchdelete(mid)
    let pat = '\<' . escape(@z, '\') . '\>'
    echo pat
    call matchadd('InterestingWord' . a:n, pat, 1, mid)
    normal! `z
endfunction
nnoremap <silent> <Leader>h1 :call <SID>HiInterestingWord(1)<cr>
nnoremap <silent> <Leader>h2 :call <SID>HiInterestingWord(2)<cr>
nnoremap <silent> <Leader>h3 :call <SID>HiInterestingWord(3)<cr>
nnoremap <silent> <Leader>h4 :call <SID>HiInterestingWord(4)<cr>

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

" }}}
" Section: Plugin options {{{
" ---------------------------

"ctrlp - FIXME nuked in favor of fzf
"let g:ctrlp_user_command = 'find %s -name .git -prune -o -name .svn -prune -o -name CMakeFiles -prune -o -name 3p_libs\* -prune -o -name thirdparty -prune -o -name .cquery -prune -o \( -type f \) -a -not -path \*.so -not -path \*.a -not -path \*.cmake -print'

" fzf
let g:fzf_laylout = { 'down': '~30%' }
nnoremap <C-P> :FZF<CR>

" UltiSnips
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" Language specific settings
let python_highlight_all=1
let c_no_curly_error=1
let $PAGER=''

" airline
let g:airline_powerline_fonts=1
let g:airline_extensions = ['branch', 'bufferline']
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

" lsp/cquery
" set these to debug cquery
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')

if v:version >= 800 && executable('cquery')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'cquery',
        \ 'cmd': {server_info->['cquery']},
        \ 'root': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \ 'initialization_options': {
        \   'cacheDirectory': $HOME . '/.cquery/',
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

" }}}
" Section: Colors! {{{
" --------------------
if is_laptop
    set background=dark
    let g:airline_theme='solarized'
    colorscheme solarized
else
    "let g:airline_theme='luna'
    "let g:airline_theme='dark'
    "let g:airline_theme='distinguished'
    "colorscheme molokai
    let g:airline_theme='onedarkish'
    colorscheme onedarkish
endif

" }}}
