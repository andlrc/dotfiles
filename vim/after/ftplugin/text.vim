setlocal formatoptions+=tn

nnoremap <buffer> <F3> :match Constant /^[0-9]\+\.\%(.\+\_$\n\)\+$/<CR>
