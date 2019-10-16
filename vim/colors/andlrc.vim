hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = 'andlrc'

set background=light

" Comment

" Baseline
hi  Normal  term=NONE  cterm=NONE  ctermfg=0  ctermbg=15

" Faded
hi  ColorColumn  term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=7
hi  Comment      term=NONE  cterm=NONE  ctermfg=8     ctermbg=NONE
hi  FoldColumn   term=NONE  cterm=NONE  ctermfg=8     ctermbg=NONE
hi  Folded       term=NONE  cterm=NONE  ctermfg=8     ctermbg=NONE
hi  LineNr       term=NONE  cterm=NONE  ctermfg=8     ctermbg=bg
hi  NonText      term=NONE  cterm=NONE  ctermfg=8     ctermbg=NONE
hi  SignColumn   term=NONE  cterm=NONE  ctermfg=8     ctermbg=NONE
hi  SpecialKey   term=NONE  cterm=NONE  ctermfg=8     ctermbg=NONE

" Highlighted
hi  CursorColumn  term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=7
hi  Cursor        term=NONE  cterm=NONE  ctermfg=fg    ctermbg=4
hi  Directory     term=NONE  cterm=NONE  ctermfg=12    ctermbg=NONE
hi  ErrorMsg      term=NONE  cterm=NONE  ctermfg=15    ctermbg=9
hi  Error         term=NONE  cterm=NONE  ctermfg=15    ctermbg=9
hi  Search        term=NONE  cterm=NONE  ctermfg=fg    ctermbg=10
hi  IncSearch     term=NONE  cterm=NONE  ctermfg=fg    ctermbg=2
hi  MatchParen    term=NONE  cterm=NONE  ctermfg=4     ctermbg=7
hi  MoreMsg       term=NONE  cterm=NONE  ctermfg=12    ctermbg=7
hi  PmenuSel      term=NONE  cterm=NONE  ctermfg=fg    ctermbg=13
hi  Question      term=NONE  cterm=NONE  ctermfg=0     ctermbg=NONE
hi  StatusLine    term=NONE  cterm=NONE  ctermfg=fg    ctermbg=fg
hi  Todo          term=NONE  cterm=NONE  ctermfg=5     ctermbg=NONE
hi  WarningMsg    term=NONE  cterm=NONE  ctermfg=0     ctermbg=11
hi  WildMenu      term=NONE  cterm=NONE  ctermfg=bg    ctermbg=fg

" Reversed
hi  PmenuSbar   term=reverse            cterm=reverse            ctermfg=NONE  ctermbg=NONE
hi  Pmenu       term=reverse            cterm=reverse            ctermfg=NONE  ctermbg=NONE
hi  PmenuThumb  term=reverse            cterm=reverse            ctermfg=NONE  ctermbg=NONE
hi  TabLineSel  term=reverse            cterm=reverse            ctermfg=NONE  ctermbg=NONE
hi  Visual      term=reverse            cterm=reverse            ctermfg=NONE  ctermbg=NONE
hi  VisualNOS   term=reverse,underline  cterm=reverse,underline  ctermfg=NONE  ctermbg=NONE

" Diff
hi  DiffAdded    term=NONE    cterm=NONE  ctermfg=2  ctermbg=NONE
hi  DiffChanged  term=NONE    cterm=NONE  ctermfg=3  ctermbg=NONE
hi  DiffRemoved  term=NONE    cterm=NONE  ctermfg=1  ctermbg=NONE
hi  link         gitDiff      Comment
hi  link         diffSubname  Comment

" Spell
hi  SpellBad    term=underline  cterm=underline  ctermfg=13  ctermbg=NONE
hi  SpellCap    term=underline  cterm=underline  ctermfg=13  ctermbg=NONE
hi  SpellLocal  term=underline  cterm=underline  ctermfg=13  ctermbg=NONE
hi  SpellRare   term=underline  cterm=underline  ctermfg=13  ctermbg=NONE

" Vim Features
hi  Menu         term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE
hi  Scrollbar    term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE
hi  TabLineFill  term=NONE  cterm=NONE  ctermfg=fg    ctermbg=NONE
hi  TabLine      term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE
hi  Tooltip      term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE

" User highlights
hi  User1  term=NONE  cterm=NONE  ctermfg=15  ctermbg=4
hi  User2  term=NONE  cterm=NONE  ctermfg=15  ctermbg=4

" Syntax Highlighting (or lack of)
hi  Boolean         term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Character       term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Conceal         term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Conditional     term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Constant        term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Debug           term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Define          term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Delimiter       term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Directive       term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Exception       term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Float           term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Format          term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Function        term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Identifier      term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Ignore          term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Include         term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Keyword         term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Label           term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Macro           term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Number          term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Operator        term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  PreCondit       term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  PreProc         term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Repeat          term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  SpecialChar     term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  SpecialComment  term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Special         term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Statement       term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  StorageClass    term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  String          term=italic  cterm=italic  ctermfg=NONE  ctermbg=NONE
hi  Structure       term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Tag             term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Title           term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Typedef         term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Type            term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
hi  Underlined      term=NONE    cterm=NONE    ctermfg=NONE  ctermbg=NONE
