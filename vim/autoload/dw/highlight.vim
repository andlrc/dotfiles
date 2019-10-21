let b:dw_highlight_match_ids = {}
function dw#highlight#Highlight(group, ...) abort
  if has_key(b:dw_highlight_match_ids, a:group)
    try
      call matchdelete(b:dw_highlight_match_ids[a:group])
    catch /./
    endtry
  endif
  if a:1 != ''
    let b:dw_highlight_match_ids[a:group] = matchadd(a:group, a:1)
  else
    let b:dw_highlight_match_ids[a:group] = matchadd(a:group, expand('<cword>'))
  endif
endfunction

function dw#highlight#Clear() abort
  try
    for [_, match_id] in items(b:dw_highlight_match_ids)
      echom '<'.match_id .'>'
      call matchdelete(match_id)
    endfor
  catch /./
  endtry
endfunction

