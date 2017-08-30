execute 'setlocal path=.,/usr/include,,' .
      \ '/usr/lib/modules/' . systemlist('uname -r')[0] . '/build/include'
setlocal commentstring=/*\ %s\ */
setlocal errorformat=%f:%l:%c:%m,%f:%l.%v-%m
setlocal keywordprg=man\ --sections=2:3:3p
