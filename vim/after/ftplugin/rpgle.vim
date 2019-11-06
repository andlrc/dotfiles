setlocal shiftwidth=2 softtabstop=2 expandtab

" IceBreak's precompiler add the seven columns in the front
let g:rpgle_indentStart = 0

" Downloaded system files should be readonly
if expand('<afile>:p') =~ '/.cache/rpgledev/'
  setlocal readonly
  setlocal nomodifiable
  setlocal noswapfile
endif

setlocal suffixesadd+=.aspx,.asmx
setlocal includeexpr=RpgleInclude(v:fname)
setlocal equalprg=rpglefmt\ -Idrupp
setlocal ignorecase

function! RpgleInclude(fname)
  let fname = a:fname

  if filereadable(fname)
    return fname
  endif

  " Lib/File,Mbr -> Lib.lib/File.file/Mbr
  let fname = substitute(fname, '/', '.lib/', '')
  let fname = substitute(fname, ',', '.file/', '')
  let path = findfile(fname, &path)
  if path !=# ''
    return path
  endif

  " ... try the file in lowercase
  let path = findfile(tolower(fname), &path)
  if path !=# ''
    return path
  endif

  " ... fail
  return fname
endfunction

let path = [ '.', '~/.cache/rpgledev' ]
let tags = [ './tags', 'tags',
        \ '~/work/gitlab/sitemule/bas/services/tags',
        \ '/mnt/dksrv206/www/Portfolio/Admin/services/tags' ]

for lib in ['basdev', 'portfolio', 'icebreak']
  call add(path, '~/.cache/rpgledev/' . lib . '.lib')
  call add(path, '~/.cache/rpgledev/' . lib . '.lib/*.file')
  call add(tags, '~/.cache/rpgledev/' . lib . '.lib/tags')
endfor

" Need to execute to expand the tilde (~, and wildcards)
exe 'setlocal path=' . join(path, ',')
exe 'setlocal tags=' . join(tags, ',')
