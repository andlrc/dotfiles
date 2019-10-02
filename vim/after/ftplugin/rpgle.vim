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

au CursorMoved <buffer> call <SID>TrackRpgleVar()
au CursorMovedI <buffer> call <SID>TrackRpgleVar()

function s:GetCursorInfo() abort
  let curline = getline('.')
  let curcol = col('.')

  let syntax = synIDattr(synID(line('.'), col('.'), 0), 'name')

  " Not the correct scope in the file
  if index(['ibTplExpr', 'rpgleDclSpec', 'rpgleDclProcName', 'rpgleDclProcBody', 'rpgleIf', 'rpgleDo', 'rpgleFor', 'rpgleSelect', 'rpgleProcCall', 'xxx', 'rpgleParenBalance', 'rpgleDclParenBalance'], syntax) == -1
    return
  endif

  let pat = join([
  \    '\%(',
  \        '\(\k\+\)',
  \        '\%(\s*(\s*\(\k\+\)\s*)\)\=',
  \        '\.',
  \    '\)\=',
  \    '\%(',
  \        '\(\k\+\)',
  \        '\%(\s*(\s*\(\k\+\)\s*)\)\=',
  \        '\.',
  \    '\)\=',
  \    '\%(',
  \        '\(\k\+\)',
  \        '\%(\s*(\s*\(\k\+\)\s*)\)\=',
  \        '\.',
  \    '\)\=',
  \    '\(\k*\%' . curcol . 'v\k\+\)',
  \     '\(\s*(\s*\k\+\s*)\)\=',
  \     '\(\s*(\)\=',
  \ ], '')

  let matches = matchlist(curline, pat)

  " No match, bail
  if len(matches) == 0
    return
  endif

  let [_, ds1, dsix1, ds2, dsix2, ds3, dsix3,
     \ ident, is_array, is_proc; _] = matches
  let ds = filter([
  \    [ds1, dsix1],
  \    [ds2, dsix2],
  \    [ds3, dsix3],
  \ ], 'v:val[0] != ""')
  if is_array != ''
    let ident_type = 'array'
  elseif is_proc != ''
    let ident_type = 'proc'
  else
    let ident_type = 'ident'
  endif

  return {
  \    'ident': ident,
  \    'ident_type': ident_type,
  \    'ds': ds
  \ }
endfunction

let b:match_id = 0
let b:match_regex = ''
function s:TrackRpgleVar() abort
  if b:match_id > 0
    try
      call matchdelete(b:match_id)
    catch /./
    endtry
    let b:match_id = 0
  endif

  let var = s:GetCursorInfo()

  if empty(var)
    " clear status
    echo ''
    return
  endif

  let dsprefix = join(map(var.ds, { key, val -> val[0] . (val[1] != '' ? '(\s*' . val[1] . '\s*)' : '') }), '.')
  if dsprefix != ''
    let dsprefix = dsprefix . '.'
  endif

  echo printf('ds = %s, ident = %s, ident_type = %s', var.ds, var.ident, var.ident_type)

  let b:match_regex = '\%(\.\s*\)\@2<!\<' . dsprefix . var.ident . '\>'
  let b:match_id = matchadd('rpgleTrackedVar', b:match_regex, -1)
endfunction

nnoremap * :call <SID>HighlightVar(1)<cr>
nnoremap # :call <SID>HighlightVar(0)<cr>

function s:HighlightVar(forward)
  if b:match_id > 0
    let regex = b:match_regex
  else
    let regex = '\<' . expand('<cword>') . '\>'
  endif

  let dir = a:forward ? '/' : 'Bb?'
  let @/ = regex
  call feedkeys(dir . regex . "\<cr>")
endfunction
