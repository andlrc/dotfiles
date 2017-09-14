" Now that IceBreak supports ``**FREE'' we can use wider size in those files
" having the compilation flag:
function! s:GetTW()
  let line = getline(1)
  if line =~? 'free="\*YES"' || line =~# '^\*\*FREE\s*$'
    return 80
  else
    return 73 " 80 - 7 columns that IceBreak adds when compiling
  endif
endfunction
let &l:textwidth = s:GetTW()

setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" IceBreak's precompiler add the seven columns in the front
let g:rpgle_indentStart = 0

setlocal suffixesadd+=.aspx,.asmx
let &l:includeexpr = 'tolower(' . &l:includeexpr . ')'

setlocal keywordprg=man\ --sections=3p,3RPG,3RPGCOMPDIR,3RPGHSPEC

setlocal makeprg=rpglemake\ %:p
setlocal errorformat=%f:%l:%c:%m

" Align dcl-XX clusters
nnoremap <silent> <localleader>s !ipcolalign 2<CR>=ip

setlocal path=.,~/.cache/rpgledev/qrpglesrc.file,
             \~/.cache/rpgledev/qasphdr.file,~/.cache/rpgledev,/mnt/dksrv206

setlocal tags=tags,/mnt/dksrv206/www/dev/bas/shared/services/tags,
             \/mnt/dksrv206/www/Portfolio/Admin/Services/tags,
             \~/.cache/rpgledev/*.file/tags

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
  mark `
  if getline('.') !~? '^\s*dcl-proc\>'
    norm [[
  endif
  " Move forward to first non declaration statement
  while 1
    norm +
    if getline('.') =~ '^\s*$'
      continue
    endif
    let syn_name = synIDattr(synID(line('.'), col('.'), 1), 'name')
    if syn_name !~# '^\%(rpgleDcl\|rpgleComment\)' ||
     \ syn_name =~# '^\%(rpgleDclProcBody\)'
      break
    endif
  endwhile
  " Move back skipping blank links leaving the cursor on the last line
  " containing a declaration statement.
  exe prevnonblank(line('.') - 1)
endfunction
nnoremap <silent> <buffer> vd :call <SID>VariableDecl()<CR>

" }}}

" vim: fdm=marker fdl=0
