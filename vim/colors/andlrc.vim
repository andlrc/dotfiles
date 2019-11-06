hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = 'andlrc'

" Comment

" Baseline
hi  Normal  ctermfg=0  ctermbg=15

" Faded
hi  ColorColumn  ctermfg=NONE  ctermbg=7
hi  Comment      ctermfg=8     ctermbg=NONE
hi  FoldColumn   ctermfg=8     ctermbg=NONE
hi  Folded       ctermfg=8     ctermbg=NONE
hi  LineNr       ctermfg=8     ctermbg=NONE
hi  NonText      ctermfg=8     ctermbg=NONE
hi  SignColumn   ctermfg=8     ctermbg=NONE
hi  SpecialKey   ctermfg=8     ctermbg=NONE

" Highlighted
hi  CursorColumn  ctermfg=NONE  ctermbg=7
hi  Cursor        ctermfg=fg    ctermbg=4
hi  Directory     ctermfg=12    ctermbg=NONE
hi  ErrorMsg      ctermfg=15    ctermbg=9
hi  Error         ctermfg=15    ctermbg=9
hi  Search        ctermfg=fg    ctermbg=10
hi  IncSearch     ctermfg=fg    ctermbg=2
hi  MatchParen    ctermfg=4     ctermbg=7
hi  MoreMsg       ctermfg=12    ctermbg=7
hi  PmenuSel      ctermfg=fg    ctermbg=13
hi  Question      ctermfg=0     ctermbg=NONE
hi  StatusLine    ctermfg=fg    ctermbg=fg
hi  Todo          ctermfg=5     ctermbg=NONE
hi  WarningMsg    ctermfg=0     ctermbg=11
hi  WildMenu      ctermfg=bg    ctermbg=fg

" Reversed
hi  PmenuSbar   cterm=reverse            ctermfg=NONE  ctermbg=NONE
hi  Pmenu       cterm=reverse            ctermfg=NONE  ctermbg=NONE
hi  PmenuThumb  cterm=reverse            ctermfg=NONE  ctermbg=NONE
hi  TabLineSel  cterm=reverse            ctermfg=NONE  ctermbg=NONE
hi  Visual      cterm=reverse            ctermfg=NONE  ctermbg=NONE
hi  VisualNOS   cterm=reverse,underline  ctermfg=NONE  ctermbg=NONE

" Diff
hi  DiffAdded    ctermfg=2    ctermbg=NONE
hi  DiffChanged  ctermfg=3    ctermbg=NONE
hi  DiffRemoved  ctermfg=1    ctermbg=NONE
hi  link         gitDiff      Comment
hi  link         diffSubname  Comment

" Spell
hi  SpellBad    cterm=underline  ctermfg=13  ctermbg=NONE
hi  SpellCap    cterm=underline  ctermfg=13  ctermbg=NONE
hi  SpellLocal  cterm=underline  ctermfg=13  ctermbg=NONE
hi  SpellRare   cterm=underline  ctermfg=13  ctermbg=NONE

" Vim Features
hi  Menu         ctermfg=NONE  ctermbg=NONE
hi  Scrollbar    ctermfg=NONE  ctermbg=NONE
hi  TabLineFill  ctermfg=fg    ctermbg=NONE
hi  TabLine      ctermfg=NONE  ctermbg=NONE
hi  Tooltip      ctermfg=NONE  ctermbg=NONE

" User highlights
hi  User1  ctermfg=15  ctermbg=4
hi  User2  ctermfg=15  ctermbg=4

" Syntax Highlighting (or lack of)
hi  Boolean         ctermfg=NONE  ctermbg=NONE
hi  Character       ctermfg=NONE  ctermbg=NONE
hi  Conceal         ctermfg=NONE  ctermbg=NONE
hi  Conditional     ctermfg=NONE  ctermbg=NONE
hi  Constant        ctermfg=NONE  ctermbg=NONE
hi  Debug           ctermfg=NONE  ctermbg=NONE
hi  Define          ctermfg=NONE  ctermbg=NONE
hi  Delimiter       ctermfg=NONE  ctermbg=NONE
hi  Directive       ctermfg=NONE  ctermbg=NONE
hi  Exception       ctermfg=NONE  ctermbg=NONE
hi  Float           ctermfg=NONE  ctermbg=NONE
hi  Format          ctermfg=NONE  ctermbg=NONE
hi  Function        ctermfg=NONE  ctermbg=NONE
hi  Identifier      ctermfg=NONE  ctermbg=NONE
hi  Ignore          ctermfg=NONE  ctermbg=NONE
hi  Include         ctermfg=NONE  ctermbg=NONE
hi  Keyword         ctermfg=NONE  ctermbg=NONE
hi  Label           ctermfg=NONE  ctermbg=NONE
hi  Macro           ctermfg=NONE  ctermbg=NONE
hi  Number          ctermfg=NONE  ctermbg=NONE
hi  Operator        ctermfg=NONE  ctermbg=NONE
hi  PreCondit       ctermfg=NONE  ctermbg=NONE
hi  PreProc         ctermfg=NONE  ctermbg=NONE
hi  Repeat          ctermfg=NONE  ctermbg=NONE
hi  SpecialChar     ctermfg=NONE  ctermbg=NONE
hi  SpecialComment  ctermfg=NONE  ctermbg=NONE
hi  Special         ctermfg=NONE  ctermbg=NONE
hi  Statement       ctermfg=NONE  ctermbg=NONE
hi  StorageClass    ctermfg=NONE  ctermbg=NONE
hi  String          ctermfg=NONE  ctermbg=NONE
hi  Structure       ctermfg=NONE  ctermbg=NONE
hi  Tag             ctermfg=NONE  ctermbg=NONE
hi  Title           ctermfg=NONE  ctermbg=NONE
hi  Typedef         ctermfg=NONE  ctermbg=NONE
hi  Type            ctermfg=NONE  ctermbg=NONE
hi  Underlined      ctermfg=NONE  ctermbg=NONE
