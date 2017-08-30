let s:sol = '\%(;\s*\|^\s*\)\@<='  " start of line
let b:match_words =
  \ s:sol.'if\>:' . s:sol.'elif\>:' . s:sol.'else\>:' . s:sol. 'fi\>,' .
  \ s:sol.'\%(for\|while\)\>:' . s:sol. 'done\>,' .
  \ s:sol.'case\>:'. s:sol . '\%(\*\|\w\)\+):' . s:sol. 'esac\>'

