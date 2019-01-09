" Used by yacc.vim and lex.vim
setlocal errorformat+=%f:%l.%v-%m
setlocal keywordprg=man\ -S2:3:3p

setlocal smarttab shiftwidth=4

" Jump between returns
let b:match_words .= ',^\w.\{-}\s*(:\<return\>:^}$'

" Change between header and source
nnoremap <buffer> <expr> <localleader>a ':e ' . findfile(expand('%:t:r') .
      \ (expand('%:e') =~? 'c' ? '.h' : '.c'), &path) . '<CR>'
