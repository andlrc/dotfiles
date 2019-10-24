" IceBreak Rpgle parser translates %>string constant<% to
" responseWriteBin(x'ASCII HEX');

syntax region  ibTplString start=/`/
                         \ skip=/``/
                         \ end=/`/
                         \ contains=ibTplExpr,@Spell,rpgleBracketedComment
syntax region  ibTplExpr matchgroup=Conceal
                         \ start=/${/
                         \ end=/}/
                         \ contains=@rpgleProcArgs
                         \ contained
syntax cluster rpgleString add=ibTplString

syntax region  rpgleString matchgroup=Label
                         \ start=/%>/
                         \ end=/<%/
                         \ contains=@Spell

if getline('1') =~ '<%' " IceBreak
  highlight link ibTplString           rpgleString
  highlight link rpgleBracketedComment rpgleComment
else
  highlight link ibTplString           Error
  highlight link rpgleBracketedComment Error
endif
