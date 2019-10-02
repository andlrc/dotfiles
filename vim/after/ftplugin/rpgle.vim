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

function s:IsValidSyntax(lnum, col) abort
  let syntax = synIDattr(synID(a:lnum, a:col, 0), 'name')

  " In the correct scope in the file
  return index([
  \    'ibTplExpr',
  \    'rpgleDclParenBalance',
  \    'rpgleDclProcBody',
  \    'rpgleDclProcName',
  \    'rpgleDclSpec',
  \    'rpgleDo',
  \    'rpgleFor',
  \    'rpgleIf',
  \    'rpgleParenBalance',
  \    'rpgleProcCall',
  \    'rpgleSelect',
  \    'xxx', ''
  \ ], syntax) > -1
endfunction

function s:GetCursorInfo() abort
  let curline = getline('.')
  let curcol = col('.')

  if !s:IsValidSyntax(line('.'), col('.'))
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
  \    '\(\k*\%' . curcol . 'c\k\+\)',
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

  " Ignore datastructure fields
  if len(ds) > 0
    return
  endif

  let dsprefix = join(map(ds, { key, val -> val[0] . (val[1] != '' ? '(\s*' . val[1] . '\s*)' : '') }), '.')
  if dsprefix != ''
    let dsprefix = dsprefix . '.'
  endif

  " Regex
  let regex = '\%(\.\s*\)\@2<!\<' . dsprefix . ident . '\>'

  " Positions
  let positions = []
  let save = winsaveview()

  call search('^\s*dcl-proc', 'b')
  let stopline = searchpos('^\s*end-proc', 'n')[0]

  let [decl_lnum, decl_col] = searchpos('^\s*\%(dcl-\%(ds\|s\|c\)\s\+\)\=\zs' . regex . '\s\+\k\+', 'n', stopline)
  if decl_lnum == 0
    normal! 1G
    let [decl_lnum, decl_col] = searchpos('^\s*\%(dcl-\%(ds\|s\|c\)\s\+\)\=\zs' . regex . '\s\+\k\+', 'n', stopline)
    let stopline = line('$')
    let global = 1

  else
    let global = 0
  endif

  " Properly a procedure and not an array
  if decl_lnum == 0 && ident_type == 'array'
    let ident_type = 'proc'
  endif

  let [lnum, col] = searchpos(regex, '', stopline)
  let [first_lnum, first_col] = [lnum, col]
  while lnum && col
    if s:IsValidSyntax(lnum, col)
      call add(positions, [lnum, col])
    endif
    let [lnum, col] = searchpos(regex, '', stopline)
    if lnum == first_lnum && col == first_col
      break
    endif
  endwhile
  call winrestview(save)

  return {
  \    'ident': ident,
  \    'ident_type': ident_type,
  \    'ds': ds,
  \    'declpos': [decl_lnum, decl_col],
  \    'global': global,
  \    'positions': positions,
  \    'regex': regex
  \ }
endfunction

let b:match_ids = []
function s:TrackRpgleVar() abort
  if !empty(b:match_ids)
    try
      for match_id in b:match_ids
        call matchdelete(match_id)
      endfor
    catch /./
    endtry
    let b:match_ids = []
  endif

  let var = s:GetCursorInfo()

  if empty(var) || var.ident_type == 'proc'
    echo ''
    return
  endif

  if var.declpos[0] == 0
    echo printf("Externally defined variable that is referenced %d times",
    \    len(var.positions))
  else
    echo printf("%s variable that is referenced %d times",
    \    var.global ? 'Global' : 'Local',
    \    len(var.positions) - 1)
  endif

  for [lnum, col] in var.positions
      let regex = '\%' . lnum . 'l\%' . col . 'c' . var.regex
      call add(b:match_ids, matchadd('rpgleTrackedVar', regex, -1))
  endfor
endfunction

nnoremap <buffer> * :call <SID>HighlightVar(1)<cr>
nnoremap <buffer> # :call <SID>HighlightVar(0)<cr>
nnoremap <buffer> gd :call <SID>GotoDecl()<cr>

function s:GotoDecl() abort
  let var = s:GetCursorInfo()

  if empty(var) || var.declpos[0] == 0
    execute 'keepj normal [[/\<' . expand('<cword>') . '\>/' . "\r"
    return
  else
    let regex = join([
    \    '\%(',
    \      join(map(var.positions, {k,v -> printf('\%%%dl\%%%dc', v[0], v[1]) }), '\|'),
    \    '\)',
    \    var.regex
    \ ], '')
    let @/ = regex
    execute printf('normal! %dG0', var.declpos[0])
    call feedkeys('/' . regex . "\<cr>hl")
  endif
endfunction

function s:HighlightVar(forward)
  let var = s:GetCursorInfo()

  if empty(var)
    let regex = '\<' . expand('<cword>') . '\>'
  else
    let regex = join([
    \    '\%(',
    \      join(map(var.positions,
    \           { key, val -> '\%'.val[0].'l\%'.val[1].'c'}), '\|'),
    \    '\)',
    \    var.regex
    \ ], '')
  endif

  let dir = a:forward ? '/' : 'Bb?'
  let @/ = regex
  call feedkeys(dir . regex . "\<cr>hl")
endfunction
