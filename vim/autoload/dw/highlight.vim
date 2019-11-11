let b:dw_highlight_match_ids = {}
function dw#highlight#Highlight(group, word) abort
  if has_key(b:dw_highlight_match_ids, a:group)
    try
      call matchdelete(b:dw_highlight_match_ids[a:group])
    catch /./
    endtry
  endif
  let b:dw_highlight_match_ids[a:group] = matchadd(a:group, a:word)
endfunction

function dw#highlight#Clear() abort
  try
    for [_, match_id] in items(b:dw_highlight_match_ids)
      call matchdelete(match_id)
    endfor
  catch /./
  endtry
endfunction

