" Vim syntax file
" Language:	C++ special highlighting for misc C++ classes
" Maintainer:	Sebastien F.
" Last Change:	2017/11/22


syn keyword cppCompiler		__builtin_prefetch __builtin__clear_cache __builtin_expect __builtin_nan __builtin_bswap16 __builtin_bswap32 __builtin_bswap64 __builtin_FUNCTION __builtin_FILE __builtin_LINE __builtin_assume_aligned __builtin_unreachable __builtin_trap __builtin_alloca __builtin_alloca_with_align __PRETTY_FUNCTION__
syn keyword cppCompiler		likely unlikely


" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    let did_cpp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  "HiLink cppCompiler  Statement
  HiLink cppCompiler  Identifier
  "HiLink cppBoostType Type
  delcommand HiLink
endif


