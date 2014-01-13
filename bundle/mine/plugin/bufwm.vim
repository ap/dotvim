function! s:KeepSwitching(cmd)
	exe a:cmd
	if winnr('$') < 2 | return | endif
	let curwin = winnr()
	let origbuf = winbufnr(curwin)
	let windows = range(1,winnr('$'))
	while len(filter(windows, 'winbufnr(v:val) == winbufnr(curwin)')) > 1
		exe a:cmd
		if winbufnr(curwin) == origbuf | break | endif
	endwhile
	return
endfunction

" quick buffer switching
nnoremap <C-N> :call<Space><SID>KeepSwitching('bnext')<CR><C-G>
nnoremap <C-P> :call<Space><SID>KeepSwitching('bprev')<CR><C-G>

" I delete buffers a lot
nnoremap <expr> ZD index(['help','quickfix'],&buftype,0,1) != -1 ? ":bwipeout\<CR>" : ":bprev \<Bar> bwipeout #\<CR>"

" missing ZZ counterpart
nnoremap ZS :w<CR>