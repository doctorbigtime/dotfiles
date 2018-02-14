" Vim syntax file
" Language:	C++ special highlighting for misc C++ classes
" Maintainer:	Sebastien F.
" Last Change:	2017/11/22


syn keyword cppGhMacro     LOG_ERROR LOG_INFO LOG_DEBUG LOG_WARN

syn keyword cppGhType      IOrderExecution
syn keyword cppGhType      Graph
syn keyword cppGhType      Node
syn keyword cppGhType      Clock
syn keyword cppGhType      Universe
syn keyword cppGhType      Symbol
syn keyword cppGhType      TradedSymbol
syn keyword cppGhType      Security
syn keyword cppGhType      Exchange
syn keyword cppGhType      File
syn keyword cppGhType      Path
syn keyword cppGhType      TempFile

" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    let did_cpp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink cppGhNamespace  Constant
  HiLink cppGhMacro      Constant
  HiLink cppGhType       Typedef
  HiLink cppGhConstant   Constant
  HiLink cppGhFunction   Function
  delcommand HiLink
endif


