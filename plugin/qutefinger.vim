if expand('<sfile>:p')!=#expand('%:p') && exists('g:loaded_qutefinger')| finish| endif| let g:loaded_qutefinger = 1
let s:save_cpo = &cpo| set cpo&vim
scriptencoding utf-8
"=============================================================================
let g:qutefinger_focus_on_open = get(g:, 'qutefinger_focus_on_open', 0)
let s:bufmappings_dfl = {'close': 'q', 'enter': '<CR>', 'next': '<C-n>', 'prev': '<C-p>'}
if exists('g:qutefinger_bufmappings')
  call extend(g:qutefinger_bufmappings, s:bufmappings_dfl, 'keep')
else
  let g:qutefinger_bufmappings = copy(s:bufmappings_dfl)
end
unlet s:bufmappings_dfl

nnoremap <silent><Plug>(qutefinger-toggle-mode)    :<C-u>call qutefinger#toggle_mode()<CR>
nnoremap <silent><Plug>(qutefinger-next)   :<C-u>call qutefinger#next()<CR>
nnoremap <silent><Plug>(qutefinger-prev)   :<C-u>call qutefinger#prev()<CR>
nnoremap <silent><Plug>(qutefinger-nfile)   :<C-u>call qutefinger#nfile()<CR>
nnoremap <silent><Plug>(qutefinger-pfile)   :<C-u>call qutefinger#pfile()<CR>
nnoremap <silent><Plug>(qutefinger-older)   :<C-u>call qutefinger#older()<CR>
nnoremap <silent><Plug>(qutefinger-newer)   :<C-u>call qutefinger#newer()<CR>
nnoremap <silent><Plug>(qutefinger-win)   :<C-u>call qutefinger#window()<CR>
nnoremap <silent><Plug>(qutefinger-close)  :<C-u>call qutefinger#close()<CR>
nnoremap <silent><Plug>(qutefinger-toggle-win)    :<C-u>call qutefinger#toggle_win()<CR>

aug qutefinger
  autocmd!
  autocmd QuickFixCmdPost [^l]*   silent call qutefinger#mode('c') | call qutefinger#window()
  autocmd QuickFixCmdPost l*      silent call qutefinger#mode('l') | call qutefinger#window()
aug END

"=============================================================================
"END "{{{1
let &cpo = s:save_cpo| unlet s:save_cpo
