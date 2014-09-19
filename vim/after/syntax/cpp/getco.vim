" Vim syntax file
" Language:	getco C++ 
"

syntax keyword cppGetcoNamespace    configuration
syntax keyword cppGetcoNamespace    tiger
syntax keyword cppGetcoNamespace    venue_gateway
syntax keyword cppGetcoNamespace    Ustack

syntax keyword cppGetcoMacro    UNIT_TEST_FIXTURE
syntax keyword cppGetcoMacro    UNIT_TEST_EX
syntax keyword cppGetcoMacro    UNIT_TEST

syntax keyword cppGetcoType     HashMap
syntax keyword cppGetcoType     EventService
syntax keyword cppGetcoType     Configuration
syntax keyword cppGetcoType     HostAddr
syntax keyword cppGetcoType     InetSockAddr
syntax keyword cppGetcoType     CharLit16
syntax keyword cppGetcoType     Timer
syntax keyword cppGetcoType     UdpSocketInterface
syntax keyword cppGetcoType     DataCallback_t
syntax keyword cppGetcoType     ContractTicker
syntax keyword cppGetcoType     Order
syntax keyword cppGetcoType     Gateway
syntax keyword cppGetcoType     max_len_string
syntax keyword cppGetcoType     Thread
syntax keyword cppGetcoType     Pool
syntax keyword cppGetcoType     ObjectPool
syntax keyword cppGetcoType     PoolAllocator

syntax keyword cppGetcoFunction int2string

" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    let did_cpp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink cppGetcoNamespace  Constant
  HiLink cppGetcoMacro      Constant
  HiLink cppGetcoType       Typedef
  HiLink cppGetcoConstant   Constant
  HiLink cppGetcoFunction   Function
  delcommand HiLink
endif
