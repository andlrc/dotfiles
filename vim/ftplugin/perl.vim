setlocal shiftwidth=2 softtabstop=2 expandtab
inoremap <buffer> # X<BS>#
setlocal errorformat=%f:%l:%c:%m
setlocal makeprg=perlcritic\ --verbose\ 1\ -3\ %
