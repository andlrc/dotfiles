setlocal suffixesadd+=.js

let &l:include = '^\s*\%(var\s\+\k\+\s*=\s*\)\=require('
let &l:define  = '^\%(' . join([
        \ '\s*var\s\+\ze\k\+\s*=\s*function\>',
        \ '\s*\ze\k\+\s*:\s*function\>',
        \ '\s*function\s\+\ze\k\+'
      \ ], '\|') . '\)'

setlocal textwidth=100

let b:match_words = '\<function\>:\<return\>,' .
                  \ '\<do\>:\<while\>,' .
                  \ '\<switch\>:\<case\>:\<default\>,' .
                  \ '\<if\>:\<else\>,' .
                  \ '\<try\>:\<catch\>:\<finally\>'

setlocal makeprg=jscs\ --no-colors\ --max-errors\ -1\ --reporter\ unix\ %
setlocal errorformat^=%f:%l:%c:\ %m

setlocal tags=js.tags,./tags,tags,html.tags

" Somewhat proper section jumping {{{1

noremap <script> <buffer> <silent> gd 
      \ :execute 'keepj normal [[/\<<C-r><C-w>\>/' . "\r"<CR>

" Defined in ``andlrc/rpgle.vim''
noremap <script> <buffer> <silent> ]] :call rpgle#movement#NextSection(
      \'^\ze\%({\\|\%(var\s\+\w\+\s*=\s*\)\=function.*{\)', '', '')<CR>
noremap <script> <buffer> <silent> ][ :call rpgle#movement#NextSection(
      \'^}', '', '')<CR>
noremap <script> <buffer> <silent> [[ :call rpgle#movement#NextSection(
      \'^\ze\%({\\|\%(var\s\+\w\+\s*=\s*\)\=function.*{\)', 'b', '')<CR>
noremap <script> <buffer> <silent> [] :call rpgle#movement#NextSection(
      \'^}', 'b', '')<CR>
