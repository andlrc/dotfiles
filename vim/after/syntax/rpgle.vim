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

syntax match   rpgleCommentQuoted    /".\{-}"/
syntax cluster rpgleCommentProps     add=rpgleCommentQuoted

highlight link rpgleCommentQuoted rpgleSpecial
highlight link ibTplString        rpgleString
