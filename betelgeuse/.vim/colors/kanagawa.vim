" Vim color file kanagawa wave
"
" Author: Sebastien Fortas
"

hi clear

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="kanagawa"

if exists("g:kanagawa_original")
    let s:kanagawa_original = g:kanagawa_original
else
    let s:kanagawa_original = 0
endif

let s:none = 'NONE'
let s:inverse = 'inverse,'
let s:vim_bg = 'bg'
let s:vim_fg = 'fg'

let s:is_dark=(&background == 'dark')

let s:gb = {}

let s:gb.background = '#1f1f28'
let s:gb.foreground = '#dcd7ba'

let s:gb.sumiInk0 = '#16161d'
let s:gb.sumiInk1 = '#181820'
let s:gb.sumiInk2 = '#1a1a22'
let s:gb.sumiInk3 = '#1f1f28'
let s:gb.sumiInk4 = '#2a2a37'
let s:gb.sumiInk5 = '#363646'
let s:gb.sumiInk6 = '#54546d'

let s:gb.waveBlue1 = '#223249'
let s:gb.waveBlue2 = '#2d4f67'

let s:gb.winterGreen = '#2b3328'
let s:gb.winterYellow = '#49443c'

let s:gb.winterRed = "#43242B"
let s:gb.winterBlue = "#252535"
let s:gb.autumnGreen = "#76946A"
let s:gb.autumnRed = "#C34043"
let s:gb.autumnYellow = "#DCA561"

" Diag
let s:gb.samuraiRed = "#E82424"
let s:gb.roninYellow = "#FF9E3B"
let s:gb.waveAqua1 = "#6A9589"
let s:gb.dragonBlue = "#658594"

" Fg and Comments
let s:gb.oldWhite = "#C8C093"
let s:gb.fujiWhite = "#DCD7BA"
let s:gb.fujiGray = "#727169"

let s:gb.oniViolet = "#957FB8"
let s:gb.oniViolet2 = "#b8b4d0"
let s:gb.crystalBlue = "#7E9CD8"
let s:gb.springViolet1 = "#938AA9"
let s:gb.springViolet2 = "#9CABCA"
let s:gb.springBlue = "#7FB4CA"
let s:gb.lightBlue = "#A3D4D5" 
let s:gb.waveAqua2 = "#7AA89F"

let s:gb.springGreen = "#98BB6C"
let s:gb.boatYellow1 = "#938056"
let s:gb.boatYellow2 = "#C0A36E"
let s:gb.carpYellow = "#E6C384"

let s:gb.sakuraPink = "#D27E99"
let s:gb.waveRed = "#E46876"
let s:gb.peachRed = "#FF5D62"
let s:gb.surimiOrange = "#FFA066"
let s:gb.katanaGray = "#717C7C"

let s:gb.dragonBlack0 = "#0d0c0c"
let s:gb.dragonBlack1 = "#12120f"
let s:gb.dragonBlack2 = "#1D1C19"
let s:gb.dragonBlack3 = "#181616"
let s:gb.dragonBlack4 = "#282727"
let s:gb.dragonBlack5 = "#393836"
let s:gb.dragonBlack6 = "#625e5a"

let s:gb.dragonWhite = "#c5c9c5"
let s:gb.dragonGreen = "#87a987"
let s:gb.dragonGreen2 = "#8a9a7b"
let s:gb.dragonPink = "#a292a3"
let s:gb.dragonOrange = "#b6927b"
let s:gb.dragonOrange2 = "#b98d7b"
let s:gb.dragonGray = "#a6a69c"
let s:gb.dragonGray2 = "#9e9b93"
let s:gb.dragonGray3 = "#7a8382"
let s:gb.dragonBlue2 = "#8ba4b0"
let s:gb.dragonViolet= "#8992a7"
let s:gb.dragonRed = "#c4746e"
let s:gb.dragonAqua = "#8ea4a2"
let s:gb.dragonAsh = "#737c73"
let s:gb.dragonTeal = "#949fb5"
let s:gb.dragonYellow = "#c4b28a"

let s:gb.lotusInk1 = "#545464"
let s:gb.lotusInk2 = "#43436c"
let s:gb.lotusGray = "#dcd7ba"
let s:gb.lotusGray2 = "#716e61"
let s:gb.lotusGray3 = "#8a8980"
let s:gb.lotusWhite0 = "#d5cea3"
let s:gb.lotusWhite1 = "#dcd5ac"
let s:gb.lotusWhite2 = "#e5ddb0"
let s:gb.lotusWhite3 = "#f2ecbc"
let s:gb.lotusWhite4 = "#e7dba0"
let s:gb.lotusWhite5 = "#e4d794"
let s:gb.lotusViolet1 = "#a09cac"
let s:gb.lotusViolet2 = "#766b90"
let s:gb.lotusViolet3 = "#c9cbd1"
let s:gb.lotusViolet4 = "#624c83"
let s:gb.lotusBlue1 = "#c7d7e0"
let s:gb.lotusBlue2 = "#b5cbd2"
let s:gb.lotusBlue3 = "#9fb5c9"
let s:gb.lotusBlue4 = "#4d699b"
let s:gb.lotusBlue5 = "#5d57a3"
let s:gb.lotusGreen = "#6f894e"
let s:gb.lotusGreen2 = "#6e915f"
let s:gb.lotusGreen3 = "#b7d0ae"
let s:gb.lotusPink = "#b35b79"
let s:gb.lotusOrange = "#cc6d00"
let s:gb.lotusOrange2 = "#e98a00"
let s:gb.lotusYellow ="#77713f"
let s:gb.lotusYellow2 = "#836f4a"
let s:gb.lotusYellow3 = "#de9800"
let s:gb.lotusYellow4 = "#f9d791"
let s:gb.lotusRed = "#c84053"
let s:gb.lotusRed2 = "#d7474b"
let s:gb.lotusRed3 = "#e82424"
let s:gb.lotusRed4 = "#d9a594"
let s:gb.lotusAqua = "#597b75"
let s:gb.lotusAqua2 = "#5e857a"
let s:gb.lotusTeal1 = "#4e8ca2"
let s:gb.lotusTeal2 = "#6693bf"
let s:gb.lotusTeal3 = "#5a7785"
let s:gb.lotusCyan = "#d7e3d8"

let s:gb.neutral_black = '#090618'
let s:gb.neutral_red = '#c34043'
let s:gb.neutral_green = '#76946a'
let s:gb.neutral_yellow = '#c0a36e'
let s:gb.neutral_blue = '#7e9cd8'
let s:gb.neutral_magenta = '#957fb8'
let s:gb.neutral_cyan = '#6a9589'
let s:gb.neutral_white = '#c8c093'

let s:gb.bright_black = '#727169'
let s:gb.bright_red = '#e82424'
let s:gb.bright_green = '#98bb6c'
let s:gb.bright_yellow = '#e6c384'
let s:gb.bright_blue = '#7fb4ca'
let s:gb.bright_magenta = '#938aa9'
let s:gb.bright_cyan = '#7aa89f'
let s:gb.bright_white = '#dcd7ba'

let s:gb.selected_background = '#2d4f67'
let s:gb.selected_foreground = '#c8c093'

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg
  
  " foreground
  let fg = a:fg

  "
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  if a:0 > 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  let histring = ['hi', a:group,
        \ 'guifg=' . fg,
        \ 'guibg=' . bg,
        \ 'gui='  . emstr,
        \ 'term='  . emstr,
        \ 'cterm='  . emstr
        \ ]
  execute join(histring, ' ')
endfunction

let s:themes = {}
let s:themes.wave = {}

let s:themes.wave.fg = s:gb.fujiWhite
let s:themes.wave.fg_dim = s:gb.oldWhite
let s:themes.wave.fg_reverse = s:gb.waveBlue1
let s:themes.wave.bg = s:gb.sumiInk3
let s:themes.wave.bg_m3 = s:gb.sumiInk0
let s:themes.wave.bg_p1 = s:gb.sumiInk4
let s:themes.wave.bg_dim = s:gb.sumiInk1
let s:themes.wave.bg_gutter = s:gb.sumiInk4
let s:themes.wave.bg_search = s:gb.waveBlue2
let s:themes.wave.bg_visual = s:gb.waveBlue1
let s:themes.wave.special = s:gb.springViolet1
let s:themes.wave.nontext = s:gb.sumiInk6

let s:themes.wave.string = s:gb.springGreen
let s:themes.wave.number = s:gb.sakuraPink
let s:themes.wave.constant = s:gb.surimiOrange
let s:themes.wave.indentifier = s:gb.carpYellow
let s:themes.wave.function = s:gb.crystalBlue
let s:themes.wave.statement = s:gb.oniViolet
let s:themes.wave.keyword = s:gb.oniViolet
let s:themes.wave.operator = s:gb.boatYellow2
let s:themes.wave.preproc = s:gb.waveRed
let s:themes.wave.type = s:gb.waveAqua2
let s:themes.wave.comment = s:gb.fujiGray
let s:themes.wave.punct = s:gb.springViolet2

let s:themes.wave.warning = s:gb.roninYellow
let s:themes.wave.ok = s:gb.springGreen
let s:themes.wave.error = s:gb.samuraiRed
let s:themes.wave.info = s:gb.dragonBlue
let s:themes.wave.hint = s:gb.waveAqua1
let s:themes.wave.removed = s:gb.autumnRed

let s:themes.wave.bg_diff_add = s:gb.winterGreen
let s:themes.wave.bg_diff_change = s:gb.winterBlue
let s:themes.wave.bg_diff_delete = s:gb.winterRed


let s:theme = s:themes.wave

" UI
call s:HL('Normal', s:theme.fg, s:theme.bg)
call s:HL('Cursor', s:none, s:none, s:inverse)
hi! link lCursor Cursor
hi! link iCursor Cursor
call s:HL('CursorLine', s:none, s:theme.bg_gutter, s:none)
" call s:HL('CursorLine', s:none, s:theme.bg_gutter, s:none)
call s:HL('SignColumn', s:theme.special, s:theme.bg_gutter)
call s:HL('Folded', s:theme.special, s:theme.bg_gutter)
call s:HL('LineNr', s:theme.nontext, s:theme.bg_gutter)
call s:HL('CursorLineNr', s:theme.warning, s:theme.bg_gutter)

call s:HL('Visual', s:none, s:theme.bg_visual)
call s:HL('Search', s:none, s:theme.bg_search)
call s:HL('StatusLine', s:theme.fg_dim)
call s:HL('StatusLineNC', s:theme.fg_dim, s:theme.bg_dim)
call s:HL('WinSeparator', s:theme.bg_m3, s:theme.bg_dim)
call s:HL('Folded', s:theme.special, s:theme.bg_p1)
call s:HL('ErrorMsg', s:theme.error)
call s:HL('WarningMsg', s:theme.warning)
call s:HL('TabLine', s:theme.special, s:theme.bg_m3)
call s:HL('TabLineFill', s:theme.bg, s:theme.bg)
call s:HL('TabLineSel', s:theme.fg_dim, s:theme.bg_p1)
hi! link VertSplit WinSeparator
call s:HL('DiffAdd', s:none, s:theme.bg_diff_add)
call s:HL('DiffChange', s:none, s:theme.bg_diff_change)
call s:HL('DiffDelete', s:theme.removed, s:theme.bg_diff_delete)

call s:HL('NonText', s:theme.nontext)

" Status line
" call s:HL(User1

" syntax
call s:HL('String', s:theme.string)
call s:HL('Number', s:theme.number)
call s:HL('Constant', s:theme.constant)
call s:HL('Identifier', s:theme.indentifier)
call s:HL('Function', s:theme.function)
call s:HL('Statement', s:theme.statement)
call s:HL('Keyword', s:theme.keyword)
call s:HL('Operator', s:theme.operator)
call s:HL('PreProc', s:theme.preproc)
call s:HL('Type', s:theme.type)
call s:HL('Comment', s:theme.comment)
call s:HL('Delimiter', s:theme.punct)
" call s:HL('Exception', s:theme.error)


" hi! link NonText KanawagaBg
" hi! link SpecialKey KanawagaBg

" hi! link vCursor Cursor
" hi! link iCursor Cursor
" hi! link lCursor Cursor

" call s:HL('Comment', s:gray, s:none, s:italic

" hi! link Comment FujiGrey
" hi! link Statement KanawagaMagenta
" hi! link Operator KanawagaYellow
" hi! link Keyword KanawagaMagenta
" hi! link Exception KanawagaBlue
" hi! link PreProc KanawagaRed
" hi! link Type KanawagaCyan
" hi! link Delimiter KanawagaMagenta
" hi! link Function KanawagaBlue


"hi Boolean         guifg=#AE81FF
"hi Character       guifg=#E6DB74
"hi Number          guifg=#AE81FF
"hi String          guifg=#E6DB74
"hi Conditional     guifg=#F92672               gui=bold
"hi Constant        guifg=#AE81FF               gui=bold
"hi Cursor          guifg=#000000 guibg=#F8F8F0
"hi Debug           guifg=#BCA3A3               gui=bold
"hi Define          guifg=#66D9EF
"hi Delimiter       guifg=#8F8F8F
"hi DiffAdd                       guibg=#13354A
"hi DiffChange      guifg=#89807D guibg=#4C4745
"hi DiffDelete      guifg=#960050 guibg=#1E0010
"hi DiffText                      guibg=#4C4745 gui=italic,bold

"hi Directory       guifg=#A6E22E               gui=bold
"hi Error           guifg=#960050 guibg=#1E0010
"hi ErrorMsg        guifg=#F92672 guibg=#232526 gui=bold
"hi Exception       guifg=#A6E22E               gui=bold
"hi Float           guifg=#AE81FF
"hi FoldColumn      guifg=#465457 guibg=#000000
"hi Folded          guifg=#465457 guibg=#000000
"hi Function        guifg=#A6E22E
"hi Identifier      guifg=#FD971F
"hi Ignore          guifg=#808080 guibg=bg
"hi IncSearch       guifg=#C4BE89 guibg=#000000

"hi Keyword         guifg=#F92672               gui=bold
"hi Label           guifg=#E6DB74               gui=none
"hi Macro           guifg=#C4BE89               gui=italic
"hi SpecialKey      guifg=#66D9EF               gui=italic

"hi MatchParen      guifg=#000000 guibg=#FD971F gui=bold
"hi ModeMsg         guifg=#E6DB74
"hi MoreMsg         guifg=#E6DB74
"hi Operator        guifg=#F92672

"" complete menu
"hi Pmenu           guifg=#66D9EF guibg=#000000
"hi PmenuSel                      guibg=#808080
"hi PmenuSbar                     guibg=#080808
"hi PmenuThumb      guifg=#66D9EF

"hi PreCondit       guifg=#A6E22E               gui=bold
"hi PreProc         guifg=#A6E22E
"hi Question        guifg=#66D9EF
"hi Repeat          guifg=#F92672               gui=bold
"hi Search          guifg=#FFFFFF guibg=#455354
"" marks column
"hi SignColumn      guifg=#A6E22E guibg=#232526
"hi SpecialChar     guifg=#F92672               gui=bold
"hi SpecialComment  guifg=#465457               gui=bold
"hi Special         guifg=#66D9EF guibg=bg      gui=italic
"hi SpecialKey      guifg=#888A85               gui=italic
"if has("spell")
"    hi SpellBad    guisp=#FF0000 gui=undercurl
"    hi SpellCap    guisp=#7070F0 gui=undercurl
"    hi SpellLocal  guisp=#70F0F0 gui=undercurl
"    hi SpellRare   guisp=#FFFFFF gui=undercurl
"endif
"hi Statement       guifg=#F92672               gui=bold
"hi StatusLine      guifg=#455354 guibg=fg
"hi StatusLineNC    guifg=#808080 guibg=#080808
"hi StorageClass    guifg=#FD971F               gui=italic
"hi Structure       guifg=#66D9EF
"hi Tag             guifg=#F92672               gui=italic
"hi Title           guifg=#ef5939
"hi Todo            guifg=#FFFFFF guibg=bg      gui=bold

"hi Typedef         guifg=#66D9EF
"hi Type            guifg=#66D9EF               gui=none
"hi Underlined      guifg=#808080               gui=underline

"hi VertSplit       guifg=#808080 guibg=#080808 gui=bold
"hi VisualNOS                     guibg=#403D3D
"hi Visual                        guibg=#403D3D
"hi WarningMsg      guifg=#FFFFFF guibg=#333333 gui=bold
"hi WildMenu        guifg=#66D9EF guibg=#000000

""
"" Support for 256-color terminal
""
"if &t_Co > 255
"   hi Boolean         ctermfg=135
"   hi Character       ctermfg=144
"   hi Number          ctermfg=135
"   hi String          ctermfg=144
"   hi Conditional     ctermfg=161               cterm=bold
"   hi Constant        ctermfg=135               cterm=bold
"   hi Cursor          ctermfg=16  ctermbg=253
"   hi Debug           ctermfg=225               cterm=bold
"   hi Define          ctermfg=81
"   hi Delimiter       ctermfg=241

"   hi DiffAdd                     ctermbg=24
"   hi DiffChange      ctermfg=181 ctermbg=239
"   hi DiffDelete      ctermfg=162 ctermbg=53
"   hi DiffText                    ctermbg=102 cterm=bold

"   hi Directory       ctermfg=118               cterm=bold
"   hi Error           ctermfg=219 ctermbg=89
"   hi ErrorMsg        ctermfg=199 ctermbg=16    cterm=bold
"   hi Exception       ctermfg=118               cterm=bold
"   hi Float           ctermfg=135
"   hi FoldColumn      ctermfg=67  ctermbg=16
"   hi Folded          ctermfg=67  ctermbg=16
"   hi Function        ctermfg=118
"   hi Identifier      ctermfg=208
"   hi Ignore          ctermfg=244 ctermbg=232
"   hi IncSearch       ctermfg=193 ctermbg=16

"   hi Keyword         ctermfg=161               cterm=bold
"   hi Label           ctermfg=229               cterm=none
"   hi Macro           ctermfg=193
"   hi SpecialKey      ctermfg=81

"   hi MatchParen      ctermfg=16  ctermbg=208 cterm=bold
"   hi ModeMsg         ctermfg=229
"   hi MoreMsg         ctermfg=229
"   hi Operator        ctermfg=161

"   " complete menu
"   hi Pmenu           ctermfg=81  ctermbg=16
"   hi PmenuSel                    ctermbg=244
"   hi PmenuSbar                   ctermbg=232
"   hi PmenuThumb      ctermfg=81

"   hi PreCondit       ctermfg=118               cterm=bold
"   hi PreProc         ctermfg=118
"   hi Question        ctermfg=81
"   hi Repeat          ctermfg=161               cterm=bold
"   hi Search          ctermfg=253 ctermbg=66

"   " marks column
"   hi SignColumn      ctermfg=118 ctermbg=235
"   hi SpecialChar     ctermfg=161               cterm=bold
"   hi SpecialComment  ctermfg=245               cterm=bold
"   hi Special         ctermfg=81  ctermbg=232
"   hi SpecialKey      ctermfg=245

"   hi Statement       ctermfg=161               cterm=bold
"   hi StatusLine      ctermfg=238 ctermbg=253
"   hi StatusLineNC    ctermfg=244 ctermbg=232
"   hi StorageClass    ctermfg=208
"   hi Structure       ctermfg=81
"   hi Tag             ctermfg=161
"   hi Title           ctermfg=166
"   hi Todo            ctermfg=231 ctermbg=232   cterm=bold

"   hi Typedef         ctermfg=81
"   hi Type            ctermfg=81                cterm=none
"   hi Underlined      ctermfg=244               cterm=underline

"   hi VertSplit       ctermfg=244 ctermbg=232   cterm=bold
"   hi VisualNOS                   ctermbg=238
"   hi Visual                      ctermbg=235
"   hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold
"   hi WildMenu        ctermfg=81  ctermbg=16

"   "hi Normal          ctermfg=252 ctermbg=233
"   hi Normal          ctermfg=252
"   hi Comment         ctermfg=59
"   hi CursorLine                  ctermbg=234   cterm=none
"   hi CursorColumn                ctermbg=234
"   "hi LineNr          ctermfg=250 ctermbg=234
"   hi LineNr          ctermfg=250 
"   "hi NonText         ctermfg=250 ctermbg=234
"   hi NonText         ctermfg=250
"end
