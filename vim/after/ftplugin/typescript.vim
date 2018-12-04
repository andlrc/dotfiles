setlocal shiftwidth=2 softtabstop=2 expandtab
setlocal cindent
setlocal indentexpr& " reset from XML
setlocal makeprg=tsc
setlocal suffixesadd^=.ts
set suffixes=.js.map,.js " mostly ignore js files
setlocal errorformat^=%f%#(%l\\,%c):\ %m
setlocal errorformat^=%f%#(%l\\,%c):\ TS%n:\ %m
setlocal errorformat^=%f%#(%l\\,%c):\ error\ TS%n:\ %m
