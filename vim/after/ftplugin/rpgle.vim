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

let path = [ '.', '~/.cache/rpgledev' ]
let tags = [ './tags', 'tags',
        \ '~/work/gitlab/sitemule/bas/services/tags',
        \ '/mnt/dksrv206/www/Portfolio/Admin/services/tags' ]

for lib in ['basdev', 'portfolio', 'icebreak']
  call add(path, '~/.cache/rpgledev/' . lib . '.lib')
  call add(path, '~/.cache/rpgledev/' . lib . '.lib/*.file')
  call add(tags, '~/.cache/rpgledev/' . lib . '.lib/tags')
endfor

" Need to execute to expand the tilde (~)
exe 'setlocal path=' . join(path, ',')
exe 'setlocal tags=' . join(tags, ',')

" Variables can only be defined and referenced from specific syntax ID's.
function! s:IsValidSyntax(lnum, col) abort
  let syntax = synIDattr(synID(a:lnum, a:col, 0), 'name')

  return index([
  \    'ibTplExpr',
  \    'rpgleDclParenBalance',
  \    'rpgleDclProcBody',
  \    'rpgleDclSpec',
  \    'rpgleDclPropName',
  \    'rpgleDo',
  \    'rpgleFor',
  \    'rpgleIf',
  \    'rpgleParenBalance',
  \    'rpgleProcCall',
  \    'rpgleSelect',
  \    'xxx', ''
  \ ], syntax) > -1
endfunction

function! s:FindDecl(regex, stopline, global) abort
  " dcl-ds, dcl-s, dcl-c
  let pos = searchpos('^\s*dcl-\%(ds\|s\|c\)\s\+\zs' . a:regex, 'n', a:stopline)
  if pos[0] > 0
    return pos
  endif

  " dcl-pi ... name type ... end-pi
  if !a:global
    let save = winsaveview()
    if searchpos('^\s*dcl-pi\>', '', a:stopline)[0] > 0
      let stopline = searchpos('^\s*end-pi\>', 'n', a:stopline)[0]
      let pos = searchpos('^\s*\zs' . a:regex, 'n', stopline)
    endif
    call winrestview(save)
    if pos[0] > 0
      return pos
    endif
  endif

  " not found
  return [0, 0]
endfunction

function! s:GetCursorInfo() abort
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

  " Ignore data structure fields
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

  " Search from procedure start
  let [decl_lnum, decl_col] = s:FindDecl(regex, stopline, 0)
  if decl_lnum == 0
    " Search from file start
    normal! 1G
    let stopline = line('$')
    let [decl_lnum, decl_col] = s:FindDecl(regex, stopline, 1)
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

function s:PrintInfo(var)
  let var = a:var
  if var.declpos[0] == 0
    echo printf("Externally defined variable that is referenced %d times",
    \    len(var.positions))
  else
    echo printf("%s variable that is referenced %d times",
    \    var.global ? 'Global' : 'Local',
    \    len(var.positions) - 1)
  endif
endfunction

function s:ClearMatches() abort
  if !empty(b:match_ids)
    try
      for match_id in b:match_ids
        call matchdelete(match_id)
      endfor
    catch /./
    endtry
    let b:match_ids = []
  endif

  if !empty(get(b:, 'current_var'))
    unlet b:current_var
  endif
endfunction

let b:match_ids = []
function! s:TrackRpgleVar() abort
  " Same identifier, no need to do anything
  if !empty(get(b:, 'current_var')) && b:current_var.ident == expand('<cword>')
    call s:PrintInfo(b:current_var)
    return
  endif

  call s:ClearMatches()
  let var = s:GetCursorInfo()
  let b:current_var = var

  if empty(var) || var.ident_type == 'proc'
    echo ''
    return
  endif

  call s:PrintInfo(var)

  for [lnum, col] in var.positions
      let regex = '\%' . lnum . 'l\%' . col . 'c' . var.regex
      call add(b:match_ids, matchadd('rpgleTrackedVar', regex, -1))
  endfor
endfunction

function! s:ChangeVar() abort
  let var = s:GetCursorInfo()
  let b:current_var = var

  if empty(var) || var.ident_type == 'proc'
    echo ''
    return
  endif

  if var.declpos[0] == 0
    " Externally defined, cannot rename
    echohl WarningMsg
    echo printf('%s is externally defined, and cannot be renamed', var.ident)
    echohl None
    return
  endif

  let regex = join([
  \    '\%(',
  \      join(map(var.positions, {k,v -> printf('\%%%dl\%%%dc', v[0], v[1]) }), '\|'),
  \    '\)',
  \    var.regex
  \ ], '')

  let new_name = input('Variable name: ')
  if new_name != ''
    let save = winsaveview()
    execute '%s~' . regex . '~' . new_name . '~g'
    call winrestview(save)
  endif
endfunction

function! s:GotoDecl() abort
  let var = get(b:, 'current_var')

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

if expand('%:e') != 'rpgleinc'
  au CursorMoved <buffer> call <SID>TrackRpgleVar()
  au InsertLeave <buffer> call <SID>TrackRpgleVar()
  au InsertEnter <buffer> call <SID>ClearMatches()

  nnoremap <buffer> gd :call <SID>GotoDecl()<cr>
  nnoremap <buffer> cv :call <SID>ChangeVar()<cr>
endif
