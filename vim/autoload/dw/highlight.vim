function dw#highlight#String(group, ...)
  if a:1 != ''
    call matchadd(a:group, a:1)
  else
    call matchadd(a:group, expand('<cword>'))
  endif
endfunction
