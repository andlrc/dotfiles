setlocal formatoptions+=tn

" Ignore case when completing
setlocal infercase

nnoremap <buffer> <F3> :match Constant /^[0-9]\+\.\%(.\+\_$\n\)\+$/<CR>
