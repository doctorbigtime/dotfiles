" Section: Options {{{
" --------------------
set nocompatible
filetype on
filetype plugin on
syntax on

set ts=2       " tabs are 4 columns
set sw=2       " number of spaces to insert for reindent
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
elseif match(hostname, 'boerboel') != -1
    let is_work=1
endif

" Some directories
let g:source_roots=['.', $HOME . '/git/src']
if is_work
let g:source_roots=[$HOME . '/src/vplat', $HOME . '/src/marcrepo/greyhound']
endif

set tags=./tags,../tags,../../tags,$HOME/git/src/tags
set path=.,../include,./include,/usr/include,/usr/local/include


" }}}
" Section: Plugins {{{
" --------------------

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

" Plugin management
execute pathogen#infect()

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/Align'
Plug 'vim-scripts/a.vim'
Plug 'benmills/vimux'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chrisbra/csv.vim'
Plug 'bling/vim-bufferline'
if is_laptop 
    Plug 'altercation/vim-colors-solarized'
endif
if v:version >= 800
    Plug 'prabirshrestha/async.vim'
    Plug 'skywind3000/asyncrun.vim'
endif
if is_laptop
    Plug 'altercation/vim-colors-solarized'
elseif is_work
    Plug 'juneedahamed/svnj.vim'
endif
Plug 'SirVer/ultisnips'

Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'zchee/deoplete-clang'

call plug#end()

" Testing deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path='/usr/lib/llvm-6.0/lib/libclang.so'
let g:deoplete#sources#clang#clang_header='/usr/include/clang'

" }}}
" Section: Autocmds {{{
" ---------------------
autocmd BufReadPost ~/.Xresources call system('xrdb -load ' . expand('%'))

augroup ft_options
    autocmd!
    autocmd FileType cpp    setlocal commentstring=//\ %s
    autocmd FileType arduino    setlocal commentstring=//\ %s
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
    let grep_cmd='egrep --exclude-dir={.git,.svn,.cquery,CMakeFiles} -I -R -n "'
                \ . query . '" '
    call asyncrun#run('<bang>', '', grep_cmd)
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

let g:gcc_basic_libraries='-lboost_system -lgtest -lgtest_main'
let g:gcc_basic_includes=''
let g:gcc_basic_cmd='g++ -g -Wall -pthread -std=c++17'
let g:clang_basic_cmd='clang++ -g -Wall -pthread -std=c++17'

function! CompileAsm(...)
    let build_cmd=g:gcc_basic_cmd . ' -S ' . g:gcc_basic_includes . ' '
                \ . expand('%') 
                \ . ' ' . join(a:000, ' ')
                \ . ' -o - '
                \ . ' | egrep -v "^[[:space:]]*\."'
    vnew | call setline(1, "# build_cmd: [" . build_cmd . "]") | execute "r! " build_cmd | normal! 1G
    execute "setlocal ft=asm bh=wipe noswf bt=nofile ro"
    "execute "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction

" Builds current file with gcc using some sane defaults.
function! BuildGcc()
    let build_cmd=g:gcc_basic_cmd . ' ' . g:gcc_basic_includes . ' '
                \ . expand('%') . ' -o ' . expand('%:r') . ' '
                \ . g:gcc_basic_libraries
    call asyncrun#run('<bang>', '', build_cmd)
    copen
endfunction

function! BuildClang()
    let build_cmd=g:clang_basic_cmd . ' ' . g:gcc_basic_includes . ' '
                \ . expand('%') . ' -o ' . expand('%:r') . ' '
                \ . g:gcc_basic_libraries
    call asyncrun#run('<bang>', '', build_cmd)
    copen
endfunction

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
        call BuildGcc()
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
command! -nargs=0 Gcc call BuildGcc()
command! -nargs=0 Clang call BuildClang()
command! -nargs=* Asm call CompileAsm(<args>)
nnoremap <F8> :Gcc<CR>
nnoremap <F9> :Make<CR>
nnoremap <F10> :Rebuild<CR>

" Utilities
function! DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    execute "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
command! DiffSaved call DiffWithSaved()

function! Scratch()
  noswapfile hide enew
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal nonu
  file scratch
endfunction

vnoremap <leader>y :w ! xclip -selection clipboard<cr>
nnoremap <leader>p :r ! xclip -o -selection clipboard<cr>

function! s:googleIt(pat)
    let q = '"' . substitute(a:pat, '["\n]', ' ', 'g') . '"'
    let q = substitute(q, '[[:punct:]]', '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
    echo printf('mimeopen "https://www.google.com/search?q=%s"', q)
endfunction
nnoremap <silent> <Leader>? :call <SID>googleIt(expand("<cWORD>"))<cr>

command! -nargs=0 -bang Browser call system('chromium ' . expand('%:p'))

" }}}
" Section: Misc commands and maps {{{
" -----------------------------------

" Sort alphabetically ignoring case
nnoremap <Leader>sa :sort i<cr>

" Make a scratch pad
command! -bar -nargs=? -bang Scratch :silent split| enew<bang>|set buftype=nofile bufhidden=hide noswapfile buflisted filetype=<args>

" global find/replace
nnoremap <F4> :%s///g<LEFT><LEFT><LEFT>

" edit .vimrc
nnoremap <Leader>ev :e ~/.vimrc<CR>
" reload .vimrc
nnoremap <Leader>sv :execute 'source ~/.vimrc'<CR>
" scratch pad
command! -bar -nargs=? -bang Scratch :silent enew<bang>|set buftype=nofile bufhidden=hide noswapfile buflisted filetype=<arg>

" better tag jumping
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
" better new window tag jumping. 
nnoremap <c-w><c-]> <c-w>g<c-]>
vnoremap <c-w><c-]> <c-w>g<c-]>

" Section: Experiment {{{
" -----------------------
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

function! DuplicateAndComment()
    normal! yyP
    :Commentary
    normal! j
endfunction

command! DC call DuplicateAndComment()

" }}}
" Section: Plugin options {{{
" ---------------------------

" fzf
let g:fzf_layout = { 'down': '~30%' }
nnoremap <c-p> :FZF<CR>

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

" Colors!

" }}}
" Section: Colors! {{{
" --------------------
if is_laptop
    set background=dark
    let g:airline_theme='gruvbox'
    colorscheme gruvbox
    "let g:airline_theme='solarized'
    "colorscheme solarized
else
    "let g:airline_theme='luna'
    "let g:airline_theme='dark'
    let g:airline_theme='distinguished'
    colorscheme molokai
endif

" }}}
