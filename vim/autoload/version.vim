function version#Bump(major) abort
  if &filetype ==# 'perl'
    let pat = '\%(my\|our\)\s\+\$VERSION\s*=\D*'
  elseif &filetype ==# 'sh'
    let pat = '\%(VERSION\|version\)=\D*'
  elseif &filetype =~# '^\%(c\|cpp\)$'
    let pat = '^\s*#define\s\+\w*VERSION\s\+\D*'
  else
    let pat = 'VERSION\s*=\D*'
  endif
  let pat = '\m\C^\(' . pat . '\)\(\d\+\)\.\(\d\+\)\(.*\)'

  let lineno = search(pat, 'cnw')
  if !lineno
    echom "No version number declaration found"
    return
  endif

  call setline(lineno, substitute(getline(lineno), pat, '\=s:Match(a:major)', ''))
endfunction

function s:Match(major)
  let major = submatch(2) 
  let minor = submatch(3) 
  let old_version = major . '.' . minor
  if a:major
    let major += 1
    let minor = 0
  else
    let minor += 1
  endif

  let l:version = major . '.' . minor

  echom 'New version is ' . l:version . ', old version was ' . old_version

  return submatch(1) . l:version . submatch(4)
endfunction


