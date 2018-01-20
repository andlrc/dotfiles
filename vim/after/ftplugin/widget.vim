" makeprg is set by ftplugin/javascript.vim
let &l:makeprg = 'widgetcs ' . &makeprg

nnoremap <buffer> <localleader>s :%!widgetcs jscs -x<CR>
