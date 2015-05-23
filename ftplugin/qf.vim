if expand('<sfile>:p')!=#expand('%:p') && exists('b:did_qutefinger_qf')| finish| endif| let b:did_qutefinger_qf = 1
let s:save_cpo = &cpo| set cpo&vim
scriptencoding utf-8
"=============================================================================
setl nobl
let s:mode = getloclist(0)!=[] ? 'l' : 'c'
exe 'nnoremap <silent><buffer>'. g:qutefinger_bufmappings.close. ' :<C-u>'. s:mode. 'close<CR>'
exe 'nnoremap <silent><buffer>'. g:qutefinger_bufmappings.enter. ' :<C-u>.'. s:mode. s:mode. '<CR>zvzz'
exe 'nnoremap <silent><buffer>'. g:qutefinger_bufmappings.next.  ' :<C-u>exe v:count. "'. s:mode. 'next"<CR>zvzz<C-w>p'
exe 'nnoremap <silent><buffer>'. g:qutefinger_bufmappings.prev.  ' :<C-u>exe v:count. "'. s:mode. 'prev"<CR>zvzz<C-w>p'
unlet s:mode

"=============================================================================
"END "{{{1
let &cpo = s:save_cpo| unlet s:save_cpo
