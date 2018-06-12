setlocal shiftwidth=2 softtabstop=2 expandtab
setlocal keywordprg=:help
nnoremap <silent> <buffer> <localleader>d
      \ /Last Change:\s*/e1<CR>C<C-r>=strftime('%b %d, %Y')<CR><ESC>j$<C-a>:noh<CR>
