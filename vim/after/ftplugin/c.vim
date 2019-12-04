" Used by yacc.vim and lex.vim
setlocal errorformat+=%f:%l.%v-%m

" open the .jinja file instead of the .{h,c} file
function! CJinjaInclude(fname)
  let fname = a:fname
  let path = findfile(fname . '.jinja', &path)
  if path !=# ''
    return path
  endif
  return fname
endfunction
setlocal includeexpr=CJinjaInclude(v:fname)
nnoremap gf :exe ': e ' . CJinjaInclude(expand('<cfile>'))<Cr>

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
