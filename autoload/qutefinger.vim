if exists('s:save_cpo')| finish| endif
let s:save_cpo = &cpo| set cpo&vim
scriptencoding utf-8
"=============================================================================
"Misc:
let s:mode = 'c'
let s:_modename = {'c': 'quickfix', 'l': 'location-list'}
function! s:get_qfwinnrs() "{{{
  let ret = []
  let save_winnr = winnr()
  windo if &bt=='quickfix' | call add(ret, winnr()) | endif
  exe save_winnr. 'wincmd w'
  return ret
endfunction
"}}}
function! s:exe(cmd) "{{{
  try
    exe a:cmd
  catch
    echoh ErrorMsg
    echom s:_modename[s:mode]. ' '. v:exception
    echoh NONE
  endtry
endfunction
"}}}


"======================================
"Main:
function! qutefinger#mode(...) "{{{
  if a:0 && has_key(s:_modename, a:1)
    let s:mode = a:1
  end
  echo s:_modename[s:mode]
  return s:mode
endfunction
"}}}
function! qutefinger#toggle_mode() "{{{
  let s:mode = {'c': 'l', 'l': 'c'}[s:mode]
  echo 'qutefinger: '. s:_modename[s:mode]. ' mode'
endfunction
"}}}
function! qutefinger#next() "{{{
  call s:exe(v:count1. s:mode. 'next')
  norm! zvzz
endfunction
"}}}
function! qutefinger#prev() "{{{
  call s:exe(v:count1. s:mode. 'prev')
  norm! zvzz
endfunction
"}}}
function! qutefinger#nfile() "{{{
  call s:exe(v:count1. s:mode. 'nfile')
  norm! zvzz
endfunction
"}}}
function! qutefinger#pfile() "{{{
  call s:exe(v:count1. s:mode. 'pfile')
  norm! zvzz
endfunction
"}}}
function! qutefinger#older() "{{{
  call s:exe(v:count1. s:mode. 'older')
endfunction
"}}}
function! qutefinger#newer() "{{{
  call s:exe(v:count1. s:mode. 'newer')
endfunction
"}}}
function! qutefinger#window() "{{{
  let save_wnr = winnr()
  exe s:mode. 'window'
  if winnr()==save_wnr
    echo s:_modename[s:mode] ': no error.'
  elseif !g:qutefinger_focus_on_open
    exe save_wnr. 'wincmd w'
  end
endfunction
"}}}
function! qutefinger#close() "{{{
  cclose
  lclose
endfunction
"}}}
function! qutefinger#toggle_win() "{{{
  let qfwinnrs = s:get_qfwinnrs()
  if qfwinnrs==[]
    call qutefinger#window()
  else
    call qutefinger#close()
  end
endfunction
"}}}

"=============================================================================
"END "{{{1
let &cpo = s:save_cpo| unlet s:save_cpo
