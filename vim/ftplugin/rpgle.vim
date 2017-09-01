" Now that IceBreak supports ``**FREE'' we can use wider size in those files
" having the compilation flag:
function! s:GetTW()
  let line = getline(1)
  if line =~? 'free="\*YES"' || line =~? '^\*\*FREE\s*$'
    return 80
  else
    return 73 " 80 - 7 columns that IceBreak adds when compiling
  endif
endfunction
let &l:textwidth = s:GetTW()

setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" IceBreak's precompiler add the seven columns in the front
let g:rpgle_indentStart = 0

" POSIX man pages is nice to look through when ``bnddir('Q2ILE')'' is used.
setlocal keywordprg=man\ --sections=3p,3RPG,3RPGCOMPDIR,3RPGHSPEC

setlocal makeprg=rpglemake\ %:p
setlocal errorformat=%f:%l:%c:%m

" Align dcl-XX clusters
nnoremap <silent> <localleader>s !ipsed 's/\t\t*/ /g;
                                       \ s/\(\w\)  */\1	/;
                                       \ s/\(\w\)  */\1	/1' \|
                                \ column -t -s'	' -o' ' \|
                                \ sed 's/^/  /'<CR>


setlocal path=.,~/.cache/rpgledev/qrpglesrc.file,
             \~/.cache/rpgledev/qasphdr.file,~/.cache/rpgledev,/mnt/dksrv206

" Match declarations but also things with ``word word'', as it must also be
" declarations inside data structures, procedure interfaces:
" dcl-ds abc;
"   myVar type(1)
"   myVar2 type2;
" end-ds;
" DdataStruct       ds
" D  key                         10I 0
let &l:define = '^\%(.\{0,7}[dD]\s*\ze\w\+\%(\s\+\w\+\|\s\+\*\|\.\.\.\)' .
              \ '\|\s*dcl-\%(proc\|pr\|ds\|[sc]\)\s\+\ze\w\+\)'

" Jump to the end of the declaration specs in the current procedure {{{

function! s:VariableDecl()
  if getline('.') !~? '^\s*dcl-proc\>'
    norm [[+
  else
    norm +
  endif
  while getline('.') =~ '^\s*$' ||
      \ synIDattr(synID(line('.'), col('.'), 1),
                \ 'name') =~ '^\%(rpgleDcl\|rpgleComment\)'
    norm +
  endwhile
endfunction
nnoremap <silent> <buffer> vd :call <SID>VariableDecl()<CR>

" }}}

" vim: fdm=marker fdl=0
