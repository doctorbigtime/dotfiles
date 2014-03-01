set ts=3
set sw=3
set ai
set nu
set hlsearch
set expandtab
color seb

function Man_page(name)
   split
   enew
   execute "man " . s:name . " | col -b"
endfunction

map K :Man_page(<cword>)<CR>

