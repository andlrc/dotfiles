setlocal expandtab shiftwidth=4 softtabstop=4
setlocal tags=html.tags,./tags,tags,js.tags

" Allow ``-'' in tags
nnoremap <buffer> <silent> <C-]>
      \ :setlocal iskeyword+=-<CR>viw<ESC>:setlocal iskeyword-=-<CR>gv<C-]>
