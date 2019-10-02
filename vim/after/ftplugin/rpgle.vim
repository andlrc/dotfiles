setlocal shiftwidth=2 softtabstop=2 expandtab

" IceBreak's precompiler add the seven columns in the front
let g:rpgle_indentStart = 0

setlocal suffixesadd+=.aspx,.asmx
setlocal includeexpr=RpgleInclude(v:fname)
setlocal equalprg=rpglefmt\ -Idrupp
setlocal ignorecase

function! RpgleInclude(fname)
  let fname = a:fname

  if filereadable(fname)
    return fname
  endif

  let fname = substitute(fname, '/', '.lib/', '')
  let fname = substitute(fname, ',', '.file/', '')
  let path = findfile(fname, &path)
  if path !=# ''
    return path
  else
    let path = findfile(tolower(fname), &path)
    if path !=# ''
      return path
    endif
  endif
  return fname
endfunction

setlocal keywordprg=man\ -S3,3RPG,3RPGCOMPDIR,3RPGHSPEC

let path = [ '.', '~/.cache/rpgledev',
        \ '~/work/gitlab/sitemule/bas/services',
        \ '/mnt/dksrv206/www/portfolio/admin/services' ]
let tags = [ './tags', 'tags',
        \ '~/work/gitlab/sitemule/bas/services/tags',
        \ '/mnt/dksrv206/www/Portfolio/Admin/services/tags' ]

for lib in ['basdev', 'portfolio', 'icebreak']
  call add(path, '~/.cache/rpgledev/' . lib . '.lib')
  call add(path, '~/.cache/rpgledev/' . lib . '.lib/*.file')
  call add(tags, '~/.cache/rpgledev/' . lib . '.lib/tags')
endfor

exe 'setlocal path=' . join(path, ',')
exe 'setlocal tags=' . join(tags, ',')

" Match declarations but also things with ``word word'', as it must also be
" declarations inside data structures, procedure interfaces:
" dcl-ds abc;
"   myVar type(1)
"   myVar2 type2;
" end-ds;
" DdataStruct       ds
" D  key                         10I 0
let &l:define = '^.\{0,7}\%([dD]\s*\ze\w\+\%(\s\+\w\+\|\s\+\*\|\.\.\.\)' .
              \ '\|\s*dcl-\%(proc\|pr\|ds\|[sc]\)\s\+\ze\w\+\)'
