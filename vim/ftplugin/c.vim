" Used by yacc.vim and lex.vim
let &l:path = '.,/usr/include,,' .
           \ '/usr/lib/modules/' .  systemlist('uname -r')[0] . '/build/include'
setlocal commentstring=/*\ %s\ */
setlocal errorformat=%f:%l:%c:%m,%f:%l.%v-%m
setlocal keywordprg=man\ --sections=2:3:3p

" Change between header and source
nnoremap <buffer> <expr> <localleader>a ':e ' . findfile(expand('%:t:r') .
      \ (expand('%:e') =~? 'c' ? '.h' : '.c'), &path) . '<CR>'
