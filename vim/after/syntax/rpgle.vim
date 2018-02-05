" IceBreak Rpgle parser translates %>string constant<% to
" responseWriteBin(x'ASCII HEX');

syntax region  rpgleString start=/`/
                         \ skip=/``/
                         \ end=/`/
                         \ contains=ibTplExpr,@Spell
syntax region  ibTplExpr matchgroup=Conceal
                         \ start=/${/
                         \ end=/}/
                         \ contains=@rpgleProcArgs

syntax region  rpgleString matchgroup=Label
                         \ start=/%>/
                         \ end=/<%/
                         \ contains=@Spell

syntax match   rpgleCommentQuoted    /".\{-}"/
syntax cluster rpgleCommentProps     add=rpgleCommentQuoted

highlight link rpgleCommentQuoted rpgleSpecial
