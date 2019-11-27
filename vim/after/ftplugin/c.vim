" Used by yacc.vim and lex.vim
setlocal errorformat+=%f:%l.%v-%m

setlocal shiftwidth=4 smarttab

setlocal smarttab shiftwidth=4

" Change between header and source
nnoremap <buffer> <expr> <localleader>a ':e ' . findfile(expand('%:t:r') .
      \ (expand('%:e') =~? 'c' ? '.h' : '.c'), &path) . '<CR>'

if has('osxdarwin')
  let &path = join([
      \ '.',
      \ systemlist('xcrun --show-sdk-path')[0] . '/usr/include',
      \ ''
    \ ], ',')
endif
