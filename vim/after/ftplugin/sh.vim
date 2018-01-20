" This makes sure that shell scripts are highlighted as bash scripts
let g:is_posix = 1

setlocal makeprg=shellcheck\ -x\ -f\ gcc\ %
